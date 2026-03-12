import sqlite3, re, json

db_file = '/users/Mark/Pictures/Backups/2024-11-06 2137/Mine-v13-3/Mine-v13-3.lrcat'

db  = sqlite3.connect(db_file)
db.row_factory = sqlite3.Row
cur = db.cursor()
table_count = 0
table_columns = {}

def guess_data_type(table, column):
    guess_cur = db.cursor()
    guess_cur.execute(f"pragma table_info({table_name})")
    for column_data in guess_cur.fetchall():
        column_name = column_data['name']
        if column_name != column:
            continue
        print(f"{column_name}: {column_data['type']}")
        if column_data['type']:
            return column_data['type']

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
    guessed_type = "<class 'str'>" # Default
    for tp in type_count:
        if type_count[tp] > max_count:
            max_count = type_count[tp]
            guessed_type = tp

    return guessed_type

datatype_map = {
    'INTEGER':          'NUMBER',
    'TEXT':             'CLOB',
    'DATETIME':         'NUMBER',
    'BLOB':             'BLOB',
    "<class 'float'>":  'NUMBER',
    "<class 'int'>":    'NUMBER',
    "<class 'str'>":    'VARCHAR2(32000)',
    "<class 'bytes'>":  'BLOB'
}

reserved_words = [
    'cluster',
    'comment',
]

constraints = [
    'PRIMARY KEY',
    'FOREIGN KEY'
]

for table in cur.execute("SELECT name, sql FROM sqlite_master WHERE type='table'  ORDER BY name").fetchall():
    table_name = table['name']
    if 'sqlite' in table_name:
        continue

    table_count += 1
    table_columns[table_name] = []
    # print(f"Now working on table {table_name}")
    oracle_sql = f'CREATE TABLE "{table_name}" (\n'
    column_sql_list = []
    pk_list = {}

    cur.execute(f"pragma table_info({table_name})")
    for column_data in cur.fetchall():
        column_name = column_data['name']

        # Avoid reserved words in column names
        for word in reserved_words:
            if word == column_name:
                column_name += '_'

        table_columns[table_name].append(column_name)
        column_sql = f"   {column_name} "

        # Data type
        found_type = guess_data_type(table_name, column_name)
        if found_type in datatype_map:
            data_type = datatype_map[found_type]
        else:
            not_found = 1
        if data_type == 'CLOB' and column_data['pk'] > 0:
            data_type = 'VARCHAR2(32000)'
        if column_name == 'xmp':
            data_type = 'BLOB'
        column_sql += data_type + ' '

        # Default value?
        # if data_type != 'BLOB':
        #     if column_data['dflt_value']:
        #         if column_data['dflt_value'] == "''":
        #             column_sql += f"DEFAULT 'null' "
        #         else:
        #             default_value = column_data['dflt_value'].replace('"', "'")
        #             column_sql += f"DEFAULT {default_value} "

            # Nullable?
            # if column_data['notnull'] == 1:
            #     column_sql += 'NOT NULL '

        # Primary key
        if column_data['pk'] != 0:
            pk_list[column_name] = column_data['pk']

        column_sql_list.append(column_sql)
        # print(column_sql)

    # Primary key
    if pk_list:
        pk_columns = ', '.join(sorted(pk_list.keys(), key = pk_list.get))
        constraint_sql = f"   CONSTRAINT {table_name}_PK PRIMARY KEY ({pk_columns})"
        column_sql_list.append(constraint_sql)
        # print(constraint_sql)

    separator = ",\n"
    oracle_sql += f"{separator.join(column_sql_list)}" + "\n)"
    print(oracle_sql)

    with open(f"tables/{table_name}.sql", "w") as f:
        f.write(f"""
{oracle_sql}

/*
{table['sql']}
*/
""")

print(f"Table count: {table_count}")

with open('table_columns.json', 'w') as f:
    f.write(json.dumps(table_columns, sort_keys=True, indent=3))
