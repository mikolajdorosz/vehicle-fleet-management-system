from pathlib import Path
import psycopg
from config import ( DB_HOST, DB_PORT, DB_NAME, DB_PASSWORD )

def main(scenario_name, db_user, password): 
    conn = psycopg.connect(
        host = DB_HOST,
        dbname = DB_NAME,
        user = db_user,
        password = password,
        port = DB_PORT
    )
    statement_notices = []
    conn.add_notice_handler(lambda diagnostic: statement_notices.append(diagnostic.message_primary))    

    sql_file = Path(__file__).parent.parent / "tests" / f"{scenario_name}.sql"
    sql = sql_file.read_text(encoding="utf-8")
    statements = [s.strip() for s in sql.split(";") if s.strip()]

    print(f"\nRunning {scenario_name} as {db_user}\n")

    with conn.cursor() as cur:
        for stmt in statements:
            print(stmt)
            statement_notices.clear()
            try:
                cur.execute(stmt)
                # SELECT results
                if cur.description:
                    rows = cur.fetchall()
                    colnames = [desc.name for desc in cur.description]
                    print("\t".join(colnames))
                    for row in rows: print("\t".join(str(v) for v in row))
                # Print all notice messages collected
                for notice in statement_notices: print("NOTICE:", notice)
                # Status message
                print(cur.statusmessage)
                conn.commit()
            except Exception as e:
                conn.rollback()
                # Print notices before the error
                for notice in statement_notices: print("NOTICE:", notice)
                print("ERROR:", e)
    conn.close()