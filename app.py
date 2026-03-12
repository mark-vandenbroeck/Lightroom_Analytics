
import sqlite3
from flask import Flask, render_template, jsonify, request

app = Flask(__name__)
DB_PATH = 'data/Lightroom_export.db'

def get_db_connection():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    return conn

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/config')
def config():
    return render_template('config.html')

def init_db():
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

# Initialize DB on start
with app.app_context():
    init_db()

@app.route('/api/stats')
def stats():
    start_month = request.args.get('start_month')
    end_month = request.args.get('end_month')
    camera = request.args.get('camera')
    lens = request.args.get('lens')

    conn = get_db_connection()
    # Base query
    query = """
        SELECT 
            strftime('%Y-%m', CaptureTime) as month,
            COUNT(*) as total_count,
            SUM(CASE WHEN pick = 1 THEN 1 ELSE 0 END) as pick_count
        FROM Lightroom_raw
        LEFT JOIN LensMappings ON Lightroom_raw.Lens = LensMappings.OriginalName
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
        # Check against the effective name (Group Name if exists, else Original)
        query += " AND COALESCE(LensMappings.GroupName, Lightroom_raw.Lens) = ?"
        params.append(lens)

    query += """
        GROUP BY month
        ORDER BY month
    """
    
    rows = conn.execute(query, params).fetchall()
    conn.close()

    labels = []
    total_data = []
    pick_data = []

    for row in rows:
        if row['month']: # Filter out any potentially weird null dates if WHERE clause missed valid format
            labels.append(row['month'])
            total_data.append(row['total_count'])
            pick_data.append(row['pick_count'])

    return jsonify({
        'labels': labels,
        'total': total_data,
        'picked': pick_data
    })

@app.route('/api/filters')
def filters():
    conn = get_db_connection()
    cameras = conn.execute("SELECT DISTINCT Camera FROM Lightroom_raw ORDER BY Camera").fetchall()
    # Get distinct effective lens names
    lenses = conn.execute("""
        SELECT DISTINCT COALESCE(lm.GroupName, lr.Lens) as LensName 
        FROM Lightroom_raw lr
        LEFT JOIN LensMappings lm ON lr.Lens = lm.OriginalName
        ORDER BY LensName
    """).fetchall()
    conn.close()
    
    return jsonify({
        'cameras': [row['Camera'] for row in cameras if row['Camera']],
        'lenses': [row['LensName'] for row in lenses if row['LensName']]
    })

@app.route('/table')
def table():
    return render_template('table.html')

@app.route('/api/mappings', methods=['GET', 'POST'])
def mappings():
    conn = get_db_connection()
    if request.method == 'POST':
        data = request.json
        # data is expected to be list of {original: '...', group: '...'}
        # or separate updates. Let's assume a simplified single update or list.
        # Implementation: loop through provided mappings and upsert
        for item in data:
            original = item.get('original')
            group = item.get('group')
            if original:
                if group and group.strip():
                    conn.execute("INSERT OR REPLACE INTO LensMappings (OriginalName, GroupName) VALUES (?, ?)", (original, group))
                else:
                    # If group is empty, remove the mapping
                    conn.execute("DELETE FROM LensMappings WHERE OriginalName = ?", (original,))
        conn.commit()
        conn.close()
        return jsonify({'status': 'success'})
    else:
        # GET: Return all distinct lenses from Raw table and their current mapping (if any)
        rows = conn.execute("""
            SELECT DISTINCT lr.Lens as OriginalName, lm.GroupName 
            FROM Lightroom_raw lr
            LEFT JOIN LensMappings lm ON lr.Lens = lm.OriginalName
            ORDER BY lr.Lens
        """).fetchall()
        conn.close()
        return jsonify([{'original': row['OriginalName'], 'group': row['GroupName'] or ''} for row in rows if row['OriginalName']])

@app.route('/api/data')
def get_data():
    start_month = request.args.get('start_month')
    end_month = request.args.get('end_month')
    camera = request.args.get('camera')
    lens = request.args.get('lens')

    conn = get_db_connection()
    query = """
        SELECT 
            CaptureTime,
            BaseName,
            Camera,
            COALESCE(lm.GroupName, lr.Lens) as Lens,
            Rating,
            pick
        FROM Lightroom_raw lr
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

    query += " ORDER BY CaptureTime DESC LIMIT 1000"
    
    rows = conn.execute(query, params).fetchall()
    conn.close()

    return jsonify([dict(row) for row in rows])

if __name__ == '__main__':
    # Port 5000 is often taken by AirPlay on macOS, using 5001 instead
    app.run(debug=True, port=5001)
