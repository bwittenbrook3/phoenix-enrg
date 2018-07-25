set -ex

heroku container:push web
heroku container:release web
