from pathlib import Path
import subprocess 
import sys
from config import DOCKER_CONTAINER, DB_NAME, DB_USER, DB_PASSWORD

def run_migrations():
    migrations_path = Path("migrations").resolve()
    if not migrations_path.exists(): return
    subprocess.run(
		[ "docker", "cp", f"{migrations_path}/.", f"{DOCKER_CONTAINER}:/migrations"],
		check = True
	)
    for sql_file in sorted(migrations_path.glob("*.sql")):
         subprocess.run(
            ["docker", "exec", "-i", DOCKER_CONTAINER, "psql", "-U", DB_USER, "-d", DB_NAME, "-f", f"/migrations/{sql_file.name}"],
            check=True
        )
      
def run_app():
    if len(sys.argv) < 3:
        print("Usage: python app/cli.py run [scenario_1|scenario_2] [admin|jan.kowalski (optional)]")
        sys.exit(1)

    scenario_name = sys.argv[2]
    db_user = sys.argv[3] if len(sys.argv) >= 4 else DB_USER
    password = DB_PASSWORD if db_user == DB_USER else db_user

    from main import main
    main(scenario_name, db_user, password)
	
if __name__ == "__main__": 
    if len(sys.argv) < 2: 
        print("Usage: python app/cli.py [migrate|run]") 
        sys.exit(1) 
        
    cmd = sys.argv [1] 
    if cmd == "migrate": run_migrations() 
    elif cmd == "run": run_app()
    else: print("Unknown command:", cmd)