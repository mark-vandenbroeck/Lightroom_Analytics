import oracledb, json, sqlite3

# SQLite connection
db_file = '/users/Mark/Pictures/Backups/2024-11-06 2137/Mine-v13-3/Mine-v13-3.lrcat'
db_in  = sqlite3.connect(db_file)
db_in.row_factory = sqlite3.Row
cur_in = db_in.cursor()

# Oracle connection
schema = 'WKSP_LIGHTROOM'
try:
    db_out = oracledb.connect(
        user            = "admin",
        password        = 'CsEhN8mTpHYz',
        dsn             = "kampanje1_high",
        config_dir      = "/Users/mark/Documents/De Kampanje/Apex/Wallet/Wallet_KAMPANJE1",
        wallet_location = "/Users/mark/Documents/De Kampanje/Apex/Wallet/Wallet_KAMPANJE1",
        wallet_password = 'CsEhN8mTpHYz'
    )
    cur_out = db_out.cursor()
    cur_out.execute(f'ALTER SESSION SET CURRENT_SCHEMA = {schema}')
    cur_out.execute('ALTER SESSION SET NLS_DATE_FORMAT="DD-MM-YYYY"')
    cur_out.execute('ALTER SESSION SET NLS_NUMERIC_CHARACTERS=",."')
except Exception as e:
    print(e)
    print('Not connected to Oracle, exiting ...')
    exit()
print('Connected to Oracle')

# JSON file with work to do
tables = []
with open('table_columns.json', 'r') as f:
    table_columns = json.load(f)
    tables = list(table_columns.keys())

for table in tables:
    print(table)
    column_list = table_columns[table]
    columns = ',\n'.join(column_list)

    # Generate SELECT statement
    select_sql = f"""
SELECT
{columns}
FROM "{table}"
"""
    # print(select_sql + '\n')

    # Generate INSERT statement
    bind_vars = ', \n'.join(list(map(lambda x: ':'+x, column_list)))
    insert_sql = f'''
INSERT INTO "{table}" (
{columns}
) VALUES (
{ bind_vars }
)
'''

    # Populate table
    cur_out.execute(f'TRUNCATE TABLE "{table}"')
    print('Table truncated')
    cur_in.execute(select_sql)
    row_count = 0

    rows = cur_in.fetchall()
    if len(rows) > 0:

        print(f"Bulk inserting {len(rows)} rows into {table}")
        cur_out.executemany(insert_sql, rows)

        # for row in rows:
        #     print(row[0])
        #     cur_out.execute(insert_sql, list(row))

        db_out.commit()

    # print(insert_sql)
