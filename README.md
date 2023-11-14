Git init
  The git init command creates a new Git repository. It can be used to convert an existing, unversioned project to a Git repository or initialize a new, empty repository.
- git init <directory>

Git URLs
  Git has its own URL syntax which is used to pass remote repository locations to Git commands. Because git clone is most commonly used on remote repositories we will examine Git URL syntax here.  
- git clone <URLs>

Git fetch
  The git fetch command downloads commits, files, and refs from a remote repository into your local repo. Fetching is what you do when you want to see what everybody else has been working on. 
- git fetch <remote>

Git push
  The git push command is used to upload local repository content to a remote repository. Pushing is how you transfer commits from your local repository to a remote repo.
- git push <remote> <branch>

Git pull
  The git pull command is used to fetch and download content from a remote repository and immediately update the local repository to match that content. 
- git pull <remote>

Git commit
  The git commit command captures a snapshot of the project's currently staged changes. Committed snapshots can be thought of as “safe” versions of a project—Git will never change them unless you explicitly ask it to.
- git commit -m "commit message"


Git stash
  Git stash temporarily shelves (or stashes) changes you've made to your working copy so you can work on something else, and then come back and re-apply them later on. 
#Stashing your work
- git stash

#Re-applying your stashed changes
- git stash apply

