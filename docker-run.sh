#!/bin/bash

#Script for custom startup / cloning git repo 

# -- Read guide -- #
GIT_USERNAME=
GIT_REPO=
GIT_TOKEN=
GIT_BRANCH=main
IS_PUBLIC=false
REBUILD_AFTER_CLONE=false
EGG="node.js"
PYTHON_SCRIPT="main.py"
# ---- guide ---- #
# GIT_USERNAME: add your git username
# GIT_REPO: add your git repo link
# GIT_TOKEN: add your git user token
# GIT_BRANCH: set the branch you want to clone
# IS_PUBLIC: set to true if your repo is public, if it's public, don't need to fill the GIT_TOKEN and GIT_USERNAME
# REBUILD_AFTER_CLONE: set to true if you want to rebuild the npm packs after cloning
# EGG: choose the type of project ("node.js" or "python")
# PYTHON_SCRIPT: set the startup file for python
# Python: you must need to have the requirements.txt

display_error() {
    echo "Error: $1"
    exit 1
}

if [ -z "$GIT_USERNAME" ] || [ -z "$GIT_REPO" ] || [ -z "$GIT_BRANCH" ] || [ -z "$IS_PUBLIC" ] || [ -z "$REBUILD_AFTER_CLONE" ]; then
    display_error "Please fill all required variables: GIT_USERNAME, GIT_REPO, GIT_BRANCH, IS_PUBLIC, REBUILD_AFTER_CLONE"
fi

if [ "$IS_PUBLIC" != "true" ] && [ "$IS_PUBLIC" != "false" ]; then
    display_error "IS_PUBLIC must be either 'true' or 'false'"
fi

if [ "$IS_PUBLIC" = true ]; then
    git init 
    git remote add origin "$GIT_REPO"
    git branch "$GIT_BRANCH"
    git fetch origin
    git config --global pull.rebase false
    git pull origin "$GIT_BRANCH" || display_error "Failed to clone the repository"
else
    if [ -z "$GIT_TOKEN" ]; then
        display_error "GIT_TOKEN is required when IS_PUBLIC is false"
fi
    GIT_REPO=$(echo "$GIT_REPO" | sed -e 's~^https://~~')
    git init
    git remote add origin "https://$GIT_USERNAME:$GIT_TOKEN@$GIT_REPO"
    git branch -M "$GIT_BRANCH"
    git fetch origin
    git config --global pull.rebase false
    git pull origin "$GIT_BRANCH" || display_error "Failed to clone the repository"
fi


if [ "$EGG" = "node.js" ]; then
if [ "$REBUILD_AFTER_CLONE" = true ]; then
    npm i || display_error "Failed to install npm packages"
    npm rebuild || display_error "Failed to rebuild npm packages"
else
    npm i || display_error "Failed to install npm packages"
fi
    clear
    echo "Starting node.js server..."
    node .
elif [ "$EGG" = "python" ]; then
    pip install -r requirements.txt || display_error "Failed to install Python dependencies"
    if [ -f "$PYTHON_SCRIPT" ]; then
    clear 
    echo "Starting Python project..."
    python "$PYTHON_SCRIPT"
    else
    display_error "Python script not found: $PYTHON_SCRIPT"
else
    display_error "Invalid value for EGG: $EGG. Supported values are 'node.js' and 'python'"
fi

# docker-run.sh - version 1.0.0
# Made by JarsScript Discord: @jarsscript
# Github of this file: https://github.com/JarsScript/docker-run
