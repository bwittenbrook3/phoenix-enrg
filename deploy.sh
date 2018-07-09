
## SETUP COMMANDS...
# heroku create phoenix-nrg-api
# git remote rename heroku phoenix-nrg-api
# heroku addons:create heroku-postgresql:hobby-dev --app phoenix-nrg-api
# heroku config:set POOL_SIZE=18 --app phoenix-nrg-api
# heroku config:set SECRET_KEY_BASE="..." --app phoenix-nrg-api
# heroku buildpacks:set "https://github.com/HashNuke/heroku-buildpack-elixir.git" --app phoenix-nrg-api

# heroku create phoenix-nrg
# git remote rename heroku phoenix-nrg
# heroku buildpacks:set heroku/nodejs --app phoenix-nrg

set -ex

git subtree push --prefix api phoenix-nrg-api master
git subtree push --prefix web phoenix-nrg master
