# Git Cheatsheet

## Remove files that have been added to the `.gitignore`

```
git rm -r --cached .
git add .
```

## Update a Fork

To merge the fork origin upstream in the current repo

```sh
git fetch upstream
git checkout master
git merge upstream/master
```

### Setup upstream
fatal: `upstream` does not appear to be a git repository

```sh
git remote -v
git remote add upstream https://github.com/[user]/[rep]
```

Then rerun the commands above

## Undo all local changes

```sh
git reset --hard
git clean -fd
```

## Delete branch locally and remote
```sh
git branch -d [branch_name] # delete locally
git push origin --delete [branch_name] # delete remote
```

## Delete all local branches (clean up)
```sh
git checkout master
git branch --merged | grep -v \* | xargs git branch -D 
```

This will delete all local branches that are listed via `git branch --merged`


## Merge single commits

```sh
git cherry-pick [commit]
```
