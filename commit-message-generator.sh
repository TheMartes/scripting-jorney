#!/bin/bash

set -e

if [[ ! -d ".git" ]] ; then
    echo "this is not a git repo"
fi

if [[ "$(git status --porcelain)" ]] ; then
  >&2 echo "you have some unfinished work to stash ;)"
  exit 2
fi

if [[ -z "BRANCH" ]] ; then
  BRANCH="main" # 'cause github doesnt like master
fi

git checkout --orphan $BRANCH >/dev/null 2>&1 || git checkout $BRANCH > /dev/null 2>&1

# Create temp commits direcotry
if [[ ! -d .commits ]] ; then
  mkdir -p .commits
fi

# Add changes file log
if [[ ! -f  .commits/changes ]] ; then
  touch .commits/changes
fi

if [[ -z "$MAX_PAST_DAYS" ]] ; then
  MAX_PAST_DAYS=365
fi

# Create commits for the past 365 days
for (( day=$MAX_PAST_DAYS; day>=1; day-- )) ; do
    # Get the past date of the commit
    day2=$(date --date="-${day} day" "+%a, %d %b %Y %X %z")

    echo "Creating commits for ${day}"

    if [[ -z "$COMMIT_NB" ]] ; then
      if [[ -z "$COMMIT_MAX" ]] ; then
        commits=$(( ( RANDOM % 6 ) + 2 ))
      else
        commits=$(( ( RANDOM % $COMMIT_MAX ) + 1 ))
      fi
    else
      commits=$COMMIT_NB
    fi

    # Create the comits
    echo "Creating ${commits} commits"
    for ((i=1;i<=${commits};i++)); do
        content=$(date -d "${day2}" +"%s")
        echo ${content}-${i} >> .commits/changes
        git add .commits/changes
        git commit -m "Commit number ${content}-${i}"
        git commit --amend --no-edit --date "${day2}"
    done
done

function yes_or_no {
    while true; do
        read -p "$* [y/n]: " yn
        case $yn in
            [YyOo]*) return 0  ;;
            [Nn]*) echo "Aborted" ; return  1 ;;
        esac
    done
}


echo
yes_or_no "wanna push this big lie?" && \
          git push --force --set-upstream origin $BRANCH || \
          echo Done 🙌

echo "Generating done. Enjoy your useless green dots on github 🤡"
