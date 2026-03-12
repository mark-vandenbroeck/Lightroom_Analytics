import oracledb, json, os

schema = 'WKSP_LIGHTROOM'
try:
    db = oracledb.connect(
        user            = "admin",
        password        = 'CsEhN8mTpHYz',
        dsn             = "kampanje1_high",
        config_dir      = "/Users/mark/Documents/De Kampanje/Apex/Wallet/Wallet_KAMPANJE1",
        wallet_location = "/Users/mark/Documents/De Kampanje/Apex/Wallet/Wallet_KAMPANJE1",
        wallet_password = 'CsEhN8mTpHYz'
    )
    cur = db.cursor()
    cur.execute(f'ALTER SESSION SET CURRENT_SCHEMA = {schema}')
    cur.execute('ALTER SESSION SET NLS_DATE_FORMAT="DD-MM-YYYY"')
    cur.execute('ALTER SESSION SET NLS_NUMERIC_CHARACTERS=",."')
except Exception as e:
    print(e)
    print('Not connected to Oracle, exiting ...')
    exit()
print('Connected to Oracle')

# Drop all tables
cur.execute(f"SELECT table_name FROM all_tables WHERE owner = '{schema}'")
tables = cur.fetchall()
for table in tables:
    sql = f'DROP TABLE {schema}."{table[0]}"'
    print(sql)
    cur.execute(sql)

tables = []
with open('table_columns.json', 'r') as f:
    table_columns = json.load(f)
    tables = list(table_columns.keys())

for table in tables:
    table_upper = table.upper()
    with open(f"tables/{table}.sql",  'rb') as f:
        ddl = f.read().decode("utf-8")

    # Drop table if it exists
    check_sql = f"SELECT COUNT(*) FROM dba_tables WHERE owner = '{schema}' AND table_name = '{table_upper}'"
    cur.execute(check_sql)
    table_exists = cur.fetchone()[0]
    if table_exists:
        cur.execute(f'DROP TABLE {table_upper}')
        print(f'Table {table_upper} dropped')

    # Create the table
    print(ddl)
    cur.execute(ddl)


