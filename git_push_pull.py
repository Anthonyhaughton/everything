import subprocess

def pull_commit_push():
    # Pull from the repository
    subprocess.run(["git", "pull"])

    # Stage all changes
    subprocess.run(["git", "add", "."])

    # Check if there are any changes to commit
    result = subprocess.run(["git", "diff-index", "--quiet", "HEAD"])
    if result.returncode == 0:
        # No changes to commit
        print("No changes to commit.")
        return
    
    # There are changes to commit
    # Get the commit message
    commit_message = input("Enter commit message: ")
    
    # Commit the changes
    subprocess.run(["git", "commit", "-a", "-m", commit_message])
    
    # Push to the repository
    subprocess.run(["git", "push"])

pull_commit_push()
