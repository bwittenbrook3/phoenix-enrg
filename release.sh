set -ex

# heroku addons:create heroku-postgresql:hobby-dev
# heroku config:set POOL_SIZE=18 --app phoenix-nrg-api

heroku container:push web
heroku container:release web
