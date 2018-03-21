# Docker Cheatsheet

## Update a Fork

To merge the fork origin upstream in the current repo

```sh
git fetch upstream
git checkout master
git merge upstream/master
``

### Setup upstream
fatal: 'upstream' does not appear to be a git repository

````
git remote -v
git remote add upstream https://github.com/[user]/[rep]
```sh

Then rerun the commands above