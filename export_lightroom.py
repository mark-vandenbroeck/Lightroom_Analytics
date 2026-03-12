import sqlite3
import os

# Configuration
SOURCE_DB_PATH = 'data/Mine-v13-3.lrcat'
DEST_DB_PATH = 'data/Lightroom_export.db'
DEST_TABLE_NAME = 'Lightroom_raw'

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
    COALESCE(ModCount.EditCount,0) AS EditCount -- remove this to avoid depedency on ModCount view
FROM
    AgLibraryFile -- every image in catalog has an entry in this table
    LEFT JOIN AgLibraryFolder ON AgLibraryFolder.id_local=AgLibraryFile.folder
    LEFT JOIN AgLibraryRootFolder ON AgLibraryRootFolder.id_local=AgLibraryFolder.rootFolder
    LEFT JOIN Adobe_images ON AgLibraryFile.id_local=Adobe_images.rootFile
    LEFT JOIN AgHarvestedExifMetadata ON AgHarvestedExifMetadata.image = Adobe_images.id_local
    LEFT JOIN AgInternedExifCameraModel ON AgInternedExifCameraModel.id_local = AgHarvestedExifMetadata.cameraModelRef
    LEFT JOIN AgInternedExifLens ON AgInternedExifLens.id_local = AgHarvestedExifMetadata.lensRef
    LEFT JOIN ModCount ON ModCount.image = Adobe_images.id_local -- remove this to avoid depedency on ModCount view
"""

def get_sqlite_type(value):
    if isinstance(value, int):
        return 'INTEGER'
    elif isinstance(value, float):
        return 'REAL'
    elif isinstance(value, str):
        return 'TEXT'
    elif value is None:
        return 'TEXT' # Default fallback
    else:
        return 'BLOB'

def main():
    print(f"Connecting to source database: {SOURCE_DB_PATH}")
    
    # Connect to source database in read-only mode just to be safe, 
    # though standard file permissions might be the real enforcement.
    # The URI syntax allows mode=ro
    try:
        conn_src = sqlite3.connect(f"file:{SOURCE_DB_PATH}?mode=ro", uri=True)
    except sqlite3.OperationalError:
        # Fallback if URI mode not supported or path issue, but trying standard first meant read-write potentially
        print("Warning: Could not open in explicit read-only mode, opening normally.")
        conn_src = sqlite3.connect(SOURCE_DB_PATH)

    cursor_src = conn_src.cursor()

    print("Executing query...")
    try:
        cursor_src.execute(QUERY)
    except sqlite3.Error as e:
        print(f"Error executing query: {e}")
        conn_src.close()
        return

    # Fetch all data
    rows = cursor_src.fetchall()
    
    if not rows:
        print("No data found.")
        conn_src.close()
        return

    # Get column names and infer types from the first row (or a sample)
    columns = [description[0] for description in cursor_src.description]
    
    # Infer schema from results (checking first non-null value for each col if possible, or just first row)
    # For simplicity, we'll check the first row. 
    # If a value is None, we default to TEXT to be safe.
    first_row = rows[0]
    col_defs = []
    for col_name, val in zip(columns, first_row):
        col_type = get_sqlite_type(val)
        col_defs.append(f'"{col_name}" {col_type}')
    
    create_table_sql = f"CREATE TABLE IF NOT EXISTS {DEST_TABLE_NAME} ({', '.join(col_defs)});"
    
    print(f"Closing source database.")
    conn_src.close()

    print(f"Connecting to destination database: {DEST_DB_PATH}")
    if os.path.exists(DEST_DB_PATH):
        print("Destination database already exists, replacing it...")
        os.remove(DEST_DB_PATH)
        
    conn_dest = sqlite3.connect(DEST_DB_PATH)
    cursor_dest = conn_dest.cursor()

    print(f"Creating table {DEST_TABLE_NAME}...")
    cursor_dest.execute(create_table_sql)

    print(f"Inserting {len(rows)} rows...")
    placeholders = ', '.join(['?'] * len(columns))
    insert_sql = f"INSERT INTO {DEST_TABLE_NAME} VALUES ({placeholders})"
    
    cursor_dest.executemany(insert_sql, rows)
    conn_dest.commit()
    
    # Verify count
    cursor_dest.execute(f"SELECT COUNT(*) FROM {DEST_TABLE_NAME}")
    count = cursor_dest.fetchone()[0]
    print(f"Successfully inserted {count} rows.")

    conn_dest.close()
    print("Done.")

if __name__ == "__main__":
    main()
