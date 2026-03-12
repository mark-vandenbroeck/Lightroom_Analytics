import sqlite3

db_file = '/users/Mark/Pictures/Backups/2024-11-06 2137/Mine-v13-3/Mine-v13-3.lrcat'
db  = sqlite3.connect(db_file)
db.row_factory = sqlite3.Row
cur = db.cursor()

table_name = 'Adobe_imageDevelopSettings'
guessed_columns = {}
cur.execute(f"pragma table_info({table_name})")
for column_data in cur.fetchall():
    column_name = column_data['name']
    print(f"{column_name}: {column_data['type']}")
    if column_data['type']:
        continue

    cur.execute(f"SELECT {column_name} FROM {table_name} WHERE {column_name} IS NOT NULL LIMIT 100")
    rows = cur.fetchall()
    type_count = {}
    for row in rows:
        column_type = str(type(row[0]))
        if column_type not in type_count:
            type_count[column_type] = 1
        else:
            type_count[column_type] += 1

    max_count = 0
    guessed_type = ''
    for tp in type_count:
        if type_count[tp] > max_count:
            max_count = type_count[tp]
            guessed_type = tp
    guessed_columns[column_name] = guessed_type

dummy = 1


