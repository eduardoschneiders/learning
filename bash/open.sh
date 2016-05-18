vim $(git status | grep modified | cut -d ' ' -f4 | xargs)
