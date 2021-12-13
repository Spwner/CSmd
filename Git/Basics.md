### If the repostory already exists
**git clone \[generated link]**
Creates a copy of the project locally.

### Otherwise
**git init**
Do it inside the folder with all the stuff.

**git remote add origin \[new repo link]**
First created on Github, then connected to machine.

### Finally
**.git**
That the folder where the magic happens...

**git status**
Shows stuff that's new or changed.

**git add \[name of files]**
Updates the status. Use `git add .` to track all.

**git reset \[files]**
Undoes the last update.

**git commit -m "\[Commit head]" -m "\[Commit body]"**
Saves the tracked changes to for real this time. Use `git commit -am "[...]"` as a shortcut (only includes modified, not new).

**git reset HEAD~\[n]**
Restores the n-th commit since the last one.

**git push \[origin] \[master]**
Sends the things saved here to Github. Use `git push -u origin master`

**git pull \[same as pull...]**
Gets what's on Github and saves it here.

**git log**
See all commits with hashes.

**git reset \[commit hash]**
Goes back to before that commit. Use `git reset --hard [commit]` to get the files unchanged.