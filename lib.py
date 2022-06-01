import subprocess


def run(command: str, ask: bool = False) -> subprocess.CompletedProcess:
    print(f"+ {command}")
    if ask:
        input("+ Press any key to continue...")
    try:
        return subprocess.run(command, shell=True, check=True)
    except subprocess.CalledProcessError as e:
        print(f"Error: {e}")
        exit(1)
