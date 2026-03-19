import sqlite3
import os
import subprocess
import platform
import json
from pathlib import Path
from flask import Flask, render_template, request, jsonify, make_response, redirect

app = Flask(__name__)
PORT = 5100
DEST_DB_PATH = 'data/Lightroom_dashboard.db'
DEST_TABLE_NAME = 'Lightroom_raw'

with open('translations.json', 'r', encoding='utf-8') as f:
    TRANSLATIONS = json.load(f)

@app.context_processor
def inject_translations():
    lang = request.cookies.get('lang', 'en')
    if lang not in ['en', 'nl']:
        lang = 'en'
    
    def t(key):
        if key in TRANSLATIONS:
            return TRANSLATIONS[key].get(lang, TRANSLATIONS[key].get('en', key))
        return key

    return dict(t=t, current_lang=lang)

@app.route('/set_language/<lang>')
def set_language(lang):
    if lang not in ['en', 'nl']:
        lang = 'en'
    res = make_response(redirect(request.referrer or '/'))
    res.set_cookie('lang', lang, max_age=31536000) # 1 year
    return res

def get_db_connection():
    conn = sqlite3.connect(DEST_DB_PATH)
    conn.row_factory = sqlite3.Row
    return conn

def init_db():
    if not os.path.exists('data'):
        os.makedirs('data')
    conn = get_db_connection()
    conn.execute("""
        CREATE TABLE IF NOT EXISTS LensMappings (
            OriginalName TEXT PRIMARY KEY,
            GroupName TEXT,
            Updated DATETIME DEFAULT CURRENT_TIMESTAMP
        )
    """)
    conn.commit()
    conn.close()

with app.app_context():
    init_db()

# The Query
QUERY = """
WITH ModCount AS (
    SELECT
        image
        ,COUNT(name) AS EditCount
    FROM Adobe_libraryImageDevelopHistoryStep
    WHERE 1=1
    AND Adobe_libraryImageDevelopHistoryStep.name NOT LIKE 'Export%'
    AND Adobe_libraryImageDevelopHistoryStep.name NOT LIKE 'Import%'
    AND Adobe_libraryImageDevelopHistoryStep.name NOT LIKE 'Print%'
    GROUP BY image
),
KeywordList AS (
    SELECT 
        image,
        GROUP_CONCAT(AgLibraryKeyword.name, ',') AS Keywords
    FROM AgLibraryKeywordImage
    JOIN AgLibraryKeyword ON AgLibraryKeyword.id_local = AgLibraryKeywordImage.tag
    GROUP BY image
)
SELECT
    AgLibraryRootFolder.name AS RootFolderName,
    AgLibraryFolder.pathFromRoot AS PathFromRoot,
    AgLibraryFile.baseName AS BaseName,
    AgLibraryFile.extension AS FileType,
    Adobe_images.captureTime as CaptureTime,
    AgLibraryFile.originalFilename AS OriginalFileName,
    COALESCE(Adobe_images.rating,0) AS Rating,
    Adobe_images.colorLabels AS ColorLabel,
    Adobe_images.touchCount AS TouchCount,
    AgHarvestedExifMetadata.focalLength AS FocalLength, -- focal length mm
    ROUND(AgHarvestedExifMetadata.aperture,3) AS Aperture,
    AgHarvestedExifMetadata.shutterSpeed AS ShutterSpeed, --format not understood
    ROUND(AgHarvestedExifMetadata.isoSpeedRating,0) AS ISO,
    COALESCE(AgInternedExifCameraModel.value,"Unknown camera") AS Camera,
    COALESCE(AgInternedExifLens.value,"Unknown lens") AS Lens,
    Adobe_images.pick,
    COALESCE(ModCount.EditCount,0) AS EditCount,
    COALESCE(KeywordList.Keywords, '') AS Keywords
FROM
    AgLibraryFile -- every image in catalog has an entry in this table
    LEFT JOIN AgLibraryFolder ON AgLibraryFolder.id_local=AgLibraryFile.folder
    LEFT JOIN AgLibraryRootFolder ON AgLibraryRootFolder.id_local=AgLibraryFolder.rootFolder
    LEFT JOIN Adobe_images ON AgLibraryFile.id_local=Adobe_images.rootFile
    LEFT JOIN AgHarvestedExifMetadata ON AgHarvestedExifMetadata.image = Adobe_images.id_local
    LEFT JOIN AgInternedExifCameraModel ON AgInternedExifCameraModel.id_local = AgHarvestedExifMetadata.cameraModelRef
    LEFT JOIN AgInternedExifLens ON AgInternedExifLens.id_local = AgHarvestedExifMetadata.lensRef
    LEFT JOIN ModCount ON ModCount.image = Adobe_images.id_local
    LEFT JOIN KeywordList ON KeywordList.image = Adobe_images.id_local
"""

def get_sqlite_type(value):
    if isinstance(value, int):
        return 'INTEGER'
    elif isinstance(value, float):
        return 'REAL'
    elif isinstance(value, str):
        return 'TEXT'
    elif value is None:
        return 'TEXT'
    else:
        return 'BLOB'


@app.route('/')
def index():
    return render_template('lightroom_dashboard.html')

@app.route('/explore')
def explore():
    return render_template('lightroom_explore.html')

@app.route('/exif')
def exif():
    return render_template('lightroom_exif.html')

@app.route('/scatter')
def scatter():
    return render_template('lightroom_scatter.html')

@app.route('/hitrate')
def hitrate():
    return render_template('lightroom_hitrate.html')

@app.route('/edits')
def edits():
    return render_template('lightroom_edits.html')

@app.route('/lensprofile')
def lensprofile():
    return render_template('lightroom_lensprofile.html')

@app.route('/config')
def config():
    return render_template('lightroom_config.html')

@app.route('/api/browse')
def browse_file():
    if os.environ.get('IN_DOCKER'):
        return jsonify({'error': 'Docker modus actief: Vul het pad handmatig in (bijv. /app/import/jouw_catalogus.lrcat).'}), 400

    try:
        if platform.system() == 'Darwin':
            # Prompt for an LRCAT file using a native macOS dialog
            script = 'POSIX path of (choose file with prompt "Select Lightroom Catalog" of type {"lrcat"})'
            result = subprocess.run(['osascript', '-e', script], capture_output=True, text=True)
            
            if result.returncode == 0:
                return jsonify({'path': result.stdout.strip()})
            else:
                return jsonify({'path': None}) # User canceled
        else:
            # Fallback for Windows/Linux using tkinter
            import tkinter as tk
            from tkinter import filedialog
            root = tk.Tk()
            root.withdraw()
            root.attributes('-topmost', True) # Bring to front
            file_path = filedialog.askopenfilename(
                title="Select Lightroom Catalog",
                filetypes=[("Lightroom Catalog", "*.lrcat"), ("All Files", "*.*")]
            )
            root.destroy()
            return jsonify({'path': file_path if file_path else None})
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@app.route('/api/import', methods=['POST'])
def import_catalog():
    data = request.json
    source_db_path = data.get('path')
    
    if not source_db_path or not os.path.exists(source_db_path):
        return jsonify({'error': 'Invalid or non-existent file path: ' + str(source_db_path)}), 400

    # Read from sourceLRCAT
    try:
        conn_src = sqlite3.connect(source_db_path)
    except Exception as e:
        return jsonify({'error': f'Failed to open LRCAT file: {str(e)}'}), 500

    cursor_src = conn_src.cursor()
    try:
        cursor_src.execute(QUERY)
        rows = cursor_src.fetchall()
        columns = [description[0] for description in cursor_src.description]
    except Exception as e:
        conn_src.close()
        return jsonify({'error': f'Failed to execute query: {str(e)}'}), 500

    conn_src.close()

    if not rows:
        return jsonify({'error': 'No data found with the given query.'}), 404

    # Save to local destination database without destroying LensMappings
    conn_dest = get_db_connection()
    cursor_dest = conn_dest.cursor()

    # Drop only the target table
    cursor_dest.execute(f"DROP TABLE IF EXISTS {DEST_TABLE_NAME}")

    # Determine column types based on the first row
    first_row = rows[0]
    col_defs = []
    for col_name, val in zip(columns, first_row):
        col_type = get_sqlite_type(val)
        col_defs.append(f'"{col_name}" {col_type}')

    create_table_sql = f"CREATE TABLE IF NOT EXISTS {DEST_TABLE_NAME} ({', '.join(col_defs)});"
    cursor_dest.execute(create_table_sql)

    placeholders = ', '.join(['?'] * len(columns))
    insert_sql = f"INSERT INTO {DEST_TABLE_NAME} VALUES ({placeholders})"
    
    cursor_dest.executemany(insert_sql, rows)
    conn_dest.commit()
    
    cursor_dest.execute(f"SELECT COUNT(*) FROM {DEST_TABLE_NAME}")
    count = cursor_dest.fetchone()[0]
    conn_dest.close()

    return jsonify({'success': True, 'rows_inserted': count})

@app.route('/api/metrics')
def metrics():
    start_month = request.args.get('start_month')
    end_month = request.args.get('end_month')
    camera = request.args.get('camera')
    lens = request.args.get('lens')

    if not os.path.exists(DEST_DB_PATH):
        return jsonify({'error': 'No database found. Please import a catalog first.'}), 404

    conn = get_db_connection()
    cursor = conn.cursor()

    where_clause = "WHERE CaptureTime IS NOT NULL"
    params = []
    
    if start_month:
        where_clause += " AND strftime('%Y-%m', CaptureTime) >= ?"
        params.append(start_month)
    if end_month:
        where_clause += " AND strftime('%Y-%m', CaptureTime) <= ?"
        params.append(end_month)
    if camera:
        where_clause += " AND Camera = ?"
        params.append(camera)
    if lens:
        where_clause += " AND COALESCE(lm.GroupName, lr.Lens) = ?"
        params.append(lens)

    query = f"""
        SELECT 
            strftime('%Y-%m', CaptureTime) as month,
            COUNT(*) as total_photos,
            SUM(CASE WHEN pick = 1 THEN 1 ELSE 0 END) as pick_count
        FROM {DEST_TABLE_NAME} lr
        LEFT JOIN LensMappings lm ON lr.Lens = lm.OriginalName
        {where_clause}
        GROUP BY month
        ORDER BY month ASC
    """
    
    try:
        rows = cursor.execute(query).fetchall()
    except Exception as e:
        return jsonify({'error': str(e)}), 500
    finally:
        conn.close()

    labels = []
    total_data = []
    pick_percent = []

    for row in rows:
        if row['month']:
            labels.append(row['month'])
            total = row['total_photos']
            total_data.append(total)
            pics = row['pick_count'] or 0
            percent = (pics / total * 100) if total > 0 else 0
            pick_percent.append(round(percent, 2))

    return jsonify({
        'labels': labels,
        'total_photos': total_data,
        'pick_percentage': pick_percent
    })

@app.route('/api/filters')
def filters():
    if not os.path.exists(DEST_DB_PATH):
        return jsonify({'cameras': [], 'lenses': []})
    conn = get_db_connection()
    try:
        cameras = conn.execute(f"SELECT DISTINCT Camera FROM {DEST_TABLE_NAME} ORDER BY Camera").fetchall()
        lenses = conn.execute(f"""
            SELECT DISTINCT COALESCE(lm.GroupName, lr.Lens) as LensName 
            FROM {DEST_TABLE_NAME} lr
            LEFT JOIN LensMappings lm ON lr.Lens = lm.OriginalName
            ORDER BY LensName
        """).fetchall()
    except:
        return jsonify({'cameras': [], 'lenses': []})
    finally:
        conn.close()
    
    return jsonify({
        'cameras': [row['Camera'] for row in cameras if row['Camera']],
        'lenses': [row['LensName'] for row in lenses if row['LensName']]
    })

@app.route('/api/mappings', methods=['GET', 'POST'])
def mappings():
    if not os.path.exists(DEST_DB_PATH):
        return jsonify([])
        
    conn = get_db_connection()
    if request.method == 'POST':
        data = request.json
        for item in data:
            original = item.get('original')
            group = item.get('group')
            if original:
                if group and group.strip():
                    conn.execute("INSERT OR REPLACE INTO LensMappings (OriginalName, GroupName) VALUES (?, ?)", (original, group))
                else:
                    conn.execute("DELETE FROM LensMappings WHERE OriginalName = ?", (original,))
        conn.commit()
        conn.close()
        return jsonify({'status': 'success'})
    else:
        try:
            rows = conn.execute(f"""
                SELECT DISTINCT lr.Lens as OriginalName, lm.GroupName 
                FROM {DEST_TABLE_NAME} lr
                LEFT JOIN LensMappings lm ON lr.Lens = lm.OriginalName
                ORDER BY lr.Lens
            """).fetchall()
        except:
            rows = []
        conn.close()
        return jsonify([{'original': row['OriginalName'], 'group': row['GroupName'] or ''} for row in rows if row['OriginalName']])

@app.route('/api/explore_metrics')
def explore_metrics():
    camera = request.args.get('camera')
    lens = request.args.get('lens')
    start_month = request.args.get('start_month')
    end_month = request.args.get('end_month')

    if not os.path.exists(DEST_DB_PATH):
        return jsonify({'error': 'No database found.'}), 404

    conn = get_db_connection()
    
    query = f"""
        SELECT 
            strftime('%Y-%m', CaptureTime) as month,
            COUNT(*) as total_photos,
            SUM(CASE WHEN pick = 1 THEN 1 ELSE 0 END) as pick_count
        FROM {DEST_TABLE_NAME} lr
        LEFT JOIN LensMappings lm ON lr.Lens = lm.OriginalName
        WHERE CaptureTime IS NOT NULL
    """
    params = []

    if start_month:
        query += " AND strftime('%Y-%m', CaptureTime) >= ?"
        params.append(start_month)
    
    if end_month:
        query += " AND strftime('%Y-%m', CaptureTime) <= ?"
        params.append(end_month)

    if camera:
        query += " AND Camera = ?"
        params.append(camera)

    if lens:
        query += " AND COALESCE(lm.GroupName, lr.Lens) = ?"
        params.append(lens)

    query += " GROUP BY month ORDER BY month ASC"
    
    try:
        rows = conn.execute(query, params).fetchall()
    except Exception as e:
        return jsonify({'error': str(e)}), 500
    finally:
        conn.close()

    labels = []
    total_data = []
    pick_data = []

    for row in rows:
        if row['month']:
            labels.append(row['month'])
            total_data.append(row['total_photos'])
            pick_data.append(row['pick_count'] or 0)

    return jsonify({
        'labels': labels,
        'total_photos': total_data,
        'pick_count': pick_data
    })

@app.route('/api/exif_metrics')
def exif_metrics():
    lang = request.cookies.get('lang', 'en')
    start_month = request.args.get('start_month')
    end_month = request.args.get('end_month')
    camera = request.args.get('camera')
    lens = request.args.get('lens')

    if not os.path.exists(DEST_DB_PATH):
        return jsonify({'error': 'No database found.'}), 404

    conn = get_db_connection()
    
    # Base WHERE clause
    where_clause = "WHERE CaptureTime IS NOT NULL AND FocalLength IS NOT NULL"
    params = []

    if start_month:
        where_clause += " AND strftime('%Y-%m', CaptureTime) >= ?"
        params.append(start_month)
    if end_month:
        where_clause += " AND strftime('%Y-%m', CaptureTime) <= ?"
        params.append(end_month)

    # Add Camera and Lens filters
    if camera:
        where_clause += " AND Camera = ?"
        params.append(camera)
    if lens:
        where_clause += " AND COALESCE(lm.GroupName, lr.Lens) = ?"
        params.append(lens)

    # 1. Focal Length Histogram (Rounded)
    query_focal = f"""
        SELECT 
            CAST(ROUND(FocalLength) AS INTEGER) as focal, 
            COUNT(*) as count 
        FROM {DEST_TABLE_NAME} lr
        LEFT JOIN LensMappings lm ON lr.Lens = lm.OriginalName
        {where_clause}
        GROUP BY focal
        ORDER BY focal ASC
    """
    
    # 2. Aperture Donut (Bucketed)
    query_aperture = f"""
        SELECT 
            CASE 
                WHEN Aperture < 2.8 THEN '< f/2.8'
                WHEN Aperture >= 2.8 AND Aperture < 4.0 THEN 'f/2.8 - f/4'
                WHEN Aperture >= 4.0 AND Aperture < 5.6 THEN 'f/4 - f/5.6'
                WHEN Aperture >= 5.6 AND Aperture < 8.0 THEN 'f/5.6 - f/8'
                WHEN Aperture >= 8.0 AND Aperture < 11.0 THEN 'f/8 - f/11'
                ELSE '>= f/11'
            END as aperture_bucket,
            COUNT(*) as count
        FROM {DEST_TABLE_NAME} lr
        LEFT JOIN LensMappings lm ON lr.Lens = lm.OriginalName
        {where_clause} AND Aperture IS NOT NULL
        GROUP BY aperture_bucket
        ORDER BY MIN(Aperture) ASC
    """

    # 3. Shutter Speed (Bucketed)
    query_shutter = f"""
        WITH ConvertedShutter AS (
            SELECT 
                1.0 / POWER(2, ShutterSpeed) AS sec
            FROM {DEST_TABLE_NAME} lr
            LEFT JOIN LensMappings lm ON lr.Lens = lm.OriginalName
            {where_clause} AND ShutterSpeed IS NOT NULL
        )
        SELECT 
            CASE 
                WHEN sec <= 0.001 THEN '{TRANSLATIONS["shutter_action"].get(lang, "Action (< 1/1000s)")}'
                WHEN sec > 0.001 AND sec <= 0.01 THEN '{TRANSLATIONS["shutter_fast"].get(lang, "Fast (1/1000s - 1/100s)")}'
                WHEN sec > 0.01 AND sec <= 0.1 THEN '{TRANSLATIONS["shutter_handheld"].get(lang, "Handheld (1/100s - 1/10s)")}'
                WHEN sec > 0.1 AND sec <= 1.0 THEN '{TRANSLATIONS["shutter_slow"].get(lang, "Slow (1/10s - 1s)")}'
                ELSE '{TRANSLATIONS["shutter_long"].get(lang, "Long Exposure (> 1s)")}'
            END as shutter_bucket,
            COUNT(*) as count,
            MIN(sec) as sort_val
        FROM ConvertedShutter
        GROUP BY shutter_bucket
        ORDER BY sort_val ASC
    """

    # 4. ISO Speed Histogram (filter out values > 8000)
    query_iso = f"""
        SELECT 
            CAST(ROUND(ISO) AS INTEGER) as iso_val, 
            COUNT(*) as count 
        FROM {DEST_TABLE_NAME} lr
        LEFT JOIN LensMappings lm ON lr.Lens = lm.OriginalName
        {where_clause} AND ISO IS NOT NULL AND ISO <= 8000
        GROUP BY iso_val
        ORDER BY iso_val ASC
    """

    try:
        focal_rows = conn.execute(query_focal, params).fetchall()
        aperture_rows = conn.execute(query_aperture, params).fetchall()
        shutter_rows = conn.execute(query_shutter, params).fetchall()
        iso_rows = conn.execute(query_iso, params).fetchall()
    except Exception as e:
        return jsonify({'error': str(e)}), 500
    finally:
        conn.close()

    result = {
        'focal': {
            'labels': [str(row['focal']) for row in focal_rows],
            'data': [row['count'] for row in focal_rows]
        },
        'aperture': {
            'labels': [row['aperture_bucket'] for row in aperture_rows],
            'data': [row['count'] for row in aperture_rows]
        },
        'shutter': {
            'labels': [row['shutter_bucket'] for row in shutter_rows],
            'data': [row['count'] for row in shutter_rows]
        },
        'iso': {
            'labels': [str(row['iso_val']) for row in iso_rows],
            'data': [row['count'] for row in iso_rows]
        }
    }

    return jsonify(result)

@app.route('/api/scatter_metrics')
def scatter_metrics():
    start_month = request.args.get('start_month')
    end_month = request.args.get('end_month')
    camera = request.args.get('camera')
    lens = request.args.get('lens')

    if not os.path.exists(DEST_DB_PATH):
        return jsonify({'error': 'No database found.'}), 404

    conn = get_db_connection()
    
    where_clause = "WHERE CaptureTime IS NOT NULL"
    params = []

    if start_month:
        where_clause += " AND strftime('%Y-%m', CaptureTime) >= ?"
        params.append(start_month)
    if end_month:
        where_clause += " AND strftime('%Y-%m', CaptureTime) <= ?"
        params.append(end_month)

    if camera:
        where_clause += " AND Camera = ?"
        params.append(camera)
    if lens:
        where_clause += " AND COALESCE(lm.GroupName, lr.Lens) = ?"
        params.append(lens)

    # Note: ShutterSpeed is APEX, so 1.0 / POWER(2, ShutterSpeed) gives seconds
    base_query = f"""
        WITH BaseData AS (
            SELECT 
                ROUND(Aperture, 1) as aperture,
                1.0 / POWER(2, ShutterSpeed) as shutter_sec,
                CAST(ROUND(ISO) AS INTEGER) as iso_val
            FROM {DEST_TABLE_NAME} lr
            LEFT JOIN LensMappings lm ON lr.Lens = lm.OriginalName
            {where_clause} 
            AND Aperture IS NOT NULL 
            AND ShutterSpeed IS NOT NULL 
            AND ISO IS NOT NULL
            AND ISO <= 8000
        )
    """

    # 1. Aperture vs Shutter
    query_as = base_query + """
        SELECT aperture, shutter_sec, COUNT(*) as count 
        FROM BaseData 
        GROUP BY aperture, shutter_sec
    """
    
    # 2. Shutter vs ISO
    query_si = base_query + """
        SELECT shutter_sec, iso_val, COUNT(*) as count 
        FROM BaseData 
        GROUP BY shutter_sec, iso_val
    """

    # 3. ISO vs Aperture
    query_ia = base_query + """
        SELECT iso_val, aperture, COUNT(*) as count 
        FROM BaseData 
        GROUP BY iso_val, aperture
    """

    try:
        as_rows = conn.execute(query_as, params).fetchall()
        si_rows = conn.execute(query_si, params).fetchall()
        ia_rows = conn.execute(query_ia, params).fetchall()
    except Exception as e:
        return jsonify({'error': str(e)}), 500
    finally:
        conn.close()

    result = {
        'aperture_shutter': [
            {'aperture': r['aperture'], 'shutter': r['shutter_sec'], 'count': r['count']} 
            for r in as_rows
        ],
        'shutter_iso': [
            {'shutter': r['shutter_sec'], 'iso': r['iso_val'], 'count': r['count']} 
            for r in si_rows
        ],
        'iso_aperture': [
            {'iso': r['iso_val'], 'aperture': r['aperture'], 'count': r['count']} 
            for r in ia_rows
        ]
    }

    return jsonify(result)

@app.route('/api/hitrate_metrics')
def hitrate_metrics():
    lang = request.cookies.get('lang', 'en')
    start_month = request.args.get('start_month')
    end_month = request.args.get('end_month')
    camera = request.args.get('camera')
    lens = request.args.get('lens')

    if not os.path.exists(DEST_DB_PATH):
        return jsonify({'error': 'No database found.'}), 404

    conn = get_db_connection()
    
    where_clause = "WHERE CaptureTime IS NOT NULL AND FocalLength IS NOT NULL AND Aperture IS NOT NULL AND ShutterSpeed IS NOT NULL"
    params = []

    if start_month:
        where_clause += " AND strftime('%Y-%m', CaptureTime) >= ?"
        params.append(start_month)
    if end_month:
        where_clause += " AND strftime('%Y-%m', CaptureTime) <= ?"
        params.append(end_month)

    if camera:
        where_clause += " AND Camera = ?"
        params.append(camera)
    if lens:
        where_clause += " AND COALESCE(lm.GroupName, lr.Lens) = ?"
        params.append(lens)

    # Note: ShutterSpeed is APEX, so 1.0 / POWER(2, ShutterSpeed) gives seconds
    
    # 1. Focal Length Hit Rate
    query_focal = f"""
        SELECT 
            CAST(ROUND(FocalLength) AS INTEGER) as label, 
            COUNT(*) as total_photos,
            SUM(CASE WHEN pick = 1 THEN 1 ELSE 0 END) as pick_count
        FROM {DEST_TABLE_NAME} lr
        LEFT JOIN LensMappings lm ON lr.Lens = lm.OriginalName
        {where_clause}
        GROUP BY label
        HAVING total_photos >= 10
        ORDER BY label ASC
    """

    # 2. Aperture Hit Rate
    query_aperture = f"""
        SELECT 
            CASE 
                WHEN Aperture < 2.8 THEN '< f/2.8'
                WHEN Aperture >= 2.8 AND Aperture < 4.0 THEN 'f/2.8 - f/4'
                WHEN Aperture >= 4.0 AND Aperture < 5.6 THEN 'f/4 - f/5.6'
                WHEN Aperture >= 5.6 AND Aperture < 8.0 THEN 'f/5.6 - f/8'
                WHEN Aperture >= 8.0 AND Aperture < 11.0 THEN 'f/8 - f/11'
                ELSE '>= f/11'
            END as label_text,
            MIN(Aperture) as sort_val,
            COUNT(*) as total_photos,
            SUM(CASE WHEN pick = 1 THEN 1 ELSE 0 END) as pick_count
        FROM {DEST_TABLE_NAME} lr
        LEFT JOIN LensMappings lm ON lr.Lens = lm.OriginalName
        {where_clause}
        GROUP BY label_text
        HAVING total_photos >= 10
        ORDER BY sort_val ASC
    """

    # 3. Shutter Speed Hit Rate
    query_shutter = f"""
        WITH ConvertedShutter AS (
            SELECT 
                1.0 / POWER(2, ShutterSpeed) AS sec,
                pick
            FROM {DEST_TABLE_NAME} lr
            LEFT JOIN LensMappings lm ON lr.Lens = lm.OriginalName
            {where_clause}
        )
        SELECT 
            CASE 
                WHEN sec <= 0.001 THEN '{TRANSLATIONS["shutter_action"].get(lang, "Action (< 1/1000s)")}'
                WHEN sec > 0.001 AND sec <= 0.01 THEN '{TRANSLATIONS["shutter_fast"].get(lang, "Fast (1/1000s - 1/100s)")}'
                WHEN sec > 0.01 AND sec <= 0.1 THEN '{TRANSLATIONS["shutter_handheld"].get(lang, "Handheld (1/100s - 1/10s)")}'
                WHEN sec > 0.1 AND sec <= 1.0 THEN '{TRANSLATIONS["shutter_slow"].get(lang, "Slow (1/10s - 1s)")}'
                ELSE '{TRANSLATIONS["shutter_long"].get(lang, "Long Exposure (> 1s)")}'
            END as label_text,
            MIN(sec) as sort_val,
            COUNT(*) as total_photos,
            SUM(CASE WHEN pick = 1 THEN 1 ELSE 0 END) as pick_count
        FROM ConvertedShutter
        GROUP BY label_text
        HAVING total_photos >= 10
        ORDER BY sort_val ASC
    """

    try:
        focal_rows = conn.execute(query_focal, params).fetchall()
        aperture_rows = conn.execute(query_aperture, params).fetchall()
        shutter_rows = conn.execute(query_shutter, params).fetchall()
    except Exception as e:
        return jsonify({'error': str(e)}), 500
    finally:
        conn.close()

    def process_rows(rows, label_key):
        return {
            'labels': [str(r[label_key]) for r in rows],
            'totals': [r['total_photos'] for r in rows],
            'picks': [r['pick_count'] for r in rows],
            'rates': [round(r['pick_count'] / r['total_photos'] * 100, 1) for r in rows]
        }

    result = {
        'focal': process_rows(focal_rows, 'label'),
        'aperture': process_rows(aperture_rows, 'label_text'),
        'shutter': process_rows(shutter_rows, 'label_text')
    }

    return jsonify(result)


@app.route('/api/edits_metrics')
def edits_metrics():
    start_month = request.args.get('start_month')
    end_month = request.args.get('end_month')
    camera = request.args.get('camera')
    lens = request.args.get('lens')

    if not os.path.exists(DEST_DB_PATH):
        return jsonify({'error': 'No database found.'}), 404

    conn = get_db_connection()
    
    where_clause = "WHERE CaptureTime IS NOT NULL"
    params = []

    if start_month:
        where_clause += " AND strftime('%Y-%m', CaptureTime) >= ?"
        params.append(start_month)
    if end_month:
        where_clause += " AND strftime('%Y-%m', CaptureTime) <= ?"
        params.append(end_month)

    if camera:
        where_clause += " AND Camera = ?"
        params.append(camera)
    if lens:
        where_clause += " AND COALESCE(lm.GroupName, lr.Lens) = ?"
        params.append(lens)
        
    # 1. Ratings Distribution
    query_ratings = f"""
        SELECT 
            Rating as rating_val,
            COUNT(*) as count
        FROM {DEST_TABLE_NAME} lr
        LEFT JOIN LensMappings lm ON lr.Lens = lm.OriginalName
        {where_clause}
        GROUP BY rating_val
        ORDER BY rating_val ASC
    """

    # 2. Avg Edits per Lens
    query_edits_lens = f"""
        SELECT 
            COALESCE(lm.GroupName, lr.Lens) AS label_text,
            AVG(lr.EditCount) AS avg_edits
        FROM {DEST_TABLE_NAME} lr
        LEFT JOIN LensMappings lm ON lr.Lens = lm.OriginalName
        {where_clause}
        GROUP BY label_text
        HAVING COUNT(*) >= 20
        ORDER BY avg_edits DESC
        LIMIT 15
    """

    # 3. Avg Edits per Camera
    query_edits_camera = f"""
        SELECT 
            Camera AS label_text,
            AVG(EditCount) AS avg_edits
        FROM {DEST_TABLE_NAME} lr
        LEFT JOIN LensMappings lm ON lr.Lens = lm.OriginalName
        {where_clause}
        GROUP BY label_text
        HAVING COUNT(*) >= 20
        ORDER BY avg_edits DESC
        LIMIT 10
    """

    try:
        ratings_rows = conn.execute(query_ratings, params).fetchall()
        
        # for lenses we need to handle the params properly since we replaced WHERE -> WHERE lr.
        # But wait, date strftime doesn't prepend lr. so let's just make the where_clause use explicit table alias if needed.
        # Actually in SQLite, CaptureTime works fine without alias if unambiguous.
        lens_rows = conn.execute(query_edits_lens, params).fetchall()
        camera_rows = conn.execute(query_edits_camera, params).fetchall()
    except Exception as e:
        return jsonify({'error': str(e)}), 500
    finally:
        conn.close()

    result = {
        'ratings': {
            'labels': [str(r['rating_val']) for r in ratings_rows],
            'data': [r['count'] for r in ratings_rows]
        },
        'lenses': {
            'labels': [str(r['label_text']) for r in lens_rows],
            'data': [round(r['avg_edits'], 2) for r in lens_rows]
        },
        'cameras': {
            'labels': [str(r['label_text']) for r in camera_rows],
            'data': [round(r['avg_edits'], 2) for r in camera_rows]
        }
    }

    return jsonify(result)


@app.route('/api/lens_list')
def lens_list():
    """Returns a list of all lenses with at least 50 photos, for the dropdown."""
    if not os.path.exists(DEST_DB_PATH):
        return jsonify([])

    conn = get_db_connection()
    query = """
        SELECT 
            lr.Lens as original_name,
            COALESCE(lm.GroupName, lr.Lens) AS display_name,
            COUNT(*) as count
        FROM Lightroom_raw lr
        LEFT JOIN LensMappings lm ON lr.Lens = lm.OriginalName
        WHERE lr.Lens IS NOT NULL AND lr.Lens != ''
        GROUP BY original_name
        HAVING count >= 50
        ORDER BY count DESC
    """
    try:
        rows = conn.execute(query).fetchall()
        lenses = [{'original_name': r['original_name'], 'display_name': r['display_name'], 'count': r['count']} for r in rows]
        return jsonify(lenses)
    except Exception as e:
        return jsonify({'error': str(e)}), 500
    finally:
        conn.close()


@app.route('/api/lens_profile_metrics')
def lens_profile_metrics():
    """Returns deep-dive stats for a single specific lens."""
    lens_name = request.args.get('lens')
    start_month = request.args.get('start_month')
    end_month = request.args.get('end_month')

    if not lens_name or not os.path.exists(DEST_DB_PATH):
        return jsonify({'error': 'Missing lens name or DB.'}), 400

    conn = get_db_connection()
    
    where_clause = "WHERE Lens = ? AND CaptureTime IS NOT NULL"
    params = [lens_name]

    if start_month:
        where_clause += " AND strftime('%Y-%m', CaptureTime) >= ?"
        params.append(start_month)
    if end_month:
        where_clause += " AND strftime('%Y-%m', CaptureTime) <= ?"
        params.append(end_month)

    # Base Stats
    query_stats = f"""
        SELECT 
            COUNT(*) as total_photos,
            SUM(CASE WHEN pick = 1 THEN 1 ELSE 0 END) as picks,
            AVG(EditCount) as avg_edits
        FROM {DEST_TABLE_NAME}
        {where_clause}
    """

    # Focal Length Behavior
    query_focal = f"""
        SELECT 
            CAST(ROUND(FocalLength) AS INTEGER) as focal_val,
            COUNT(*) as count
        FROM {DEST_TABLE_NAME}
        {where_clause} AND FocalLength IS NOT NULL
        GROUP BY focal_val
        ORDER BY focal_val ASC
    """

    # Aperture Preference
    query_aperture = f"""
        SELECT 
            ROUND(Aperture, 1) as aperture_val,
            COUNT(*) as count
        FROM {DEST_TABLE_NAME}
        {where_clause} AND Aperture IS NOT NULL
        GROUP BY aperture_val
        ORDER BY count DESC
        LIMIT 10
    """

    try:
        stats = conn.execute(query_stats, params).fetchone()
        if not stats or stats['total_photos'] == 0:
            return jsonify({'focal': {'labels': []}})

        focal_rows = conn.execute(query_focal, params).fetchall()
        aperture_rows = conn.execute(query_aperture, params).fetchall()
        
        total = stats['total_photos']
        picks = stats['picks'] or 0
        
        result = {
            'stats': {
                'total': total,
                'picks': picks,
                'hit_rate': round(picks / total * 100, 1) if total > 0 else 0,
                'avg_edits': round(stats['avg_edits'], 1) if stats['avg_edits'] else 0
            },
            'focal': {
                'labels': [str(r['focal_val']) for r in focal_rows],
                'data': [r['count'] for r in focal_rows]
            },
            'aperture': {
                'labels': [str(r['aperture_val']) for r in aperture_rows],
                'data': [r['count'] for r in aperture_rows]
            }
        }
        return jsonify(result)
    except Exception as e:
        return jsonify({'error': str(e)}), 500
    finally:
        conn.close()


@app.route('/api/keyword_metrics')
def keyword_metrics():
    """Returns aggregated keyword counts for word cloud."""
    only_picks = request.args.get('only_picks', 'false').lower() == 'true'
    start_month = request.args.get('start_month')
    end_month = request.args.get('end_month')
    camera = request.args.get('camera')
    lens = request.args.get('lens')

    if not os.path.exists(DEST_DB_PATH):
        return jsonify([])

    conn = get_db_connection()
    try:
        where_clause = "WHERE Keywords IS NOT NULL AND Keywords != ''"
        params = []
        
        if only_picks:
            where_clause += " AND pick = 1"
        if start_month:
            where_clause += " AND strftime('%Y-%m', CaptureTime) >= ?"
            params.append(start_month)
        if end_month:
            where_clause += " AND strftime('%Y-%m', CaptureTime) <= ?"
            params.append(end_month)
        if camera:
            where_clause += " AND Camera = ?"
            params.append(camera)
        if lens:
            where_clause += " AND COALESCE(lm.GroupName, lr.Lens) = ?"
            params.append(lens)

        query = f"""
            SELECT Keywords 
            FROM {DEST_TABLE_NAME} lr
            LEFT JOIN LensMappings lm ON lr.Lens = lm.OriginalName 
            {where_clause}
        """
        rows = conn.execute(query, params).fetchall()
    except Exception as e:
        return jsonify({'error': str(e)}), 500
    finally:
        conn.close()

    from collections import Counter
    keyword_counts = Counter()
    for row in rows:
        # Keywords are comma-separated string from GROUP_CONCAT
        kws = [k.strip() for k in row['Keywords'].split(',')]
        for kw in kws:
            if kw:
                keyword_counts[kw] += 1

    # Format for word cloud: [{text: "Nature", weight: 45}, ...]
    # Top 45 keywords to not overload the chart
    cloud_data = [{'text': k, 'weight': v} for k, v in keyword_counts.most_common(45)]
    return jsonify(cloud_data)


if __name__ == '__main__':
    host = '0.0.0.0'
    app.run(debug=True, host=host, port=PORT)
