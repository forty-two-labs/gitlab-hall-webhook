# gitlab-hall-webhook

Sinatra app that forwards gitlab webhook message to hall.

Ready for heroku deployment.

## Setup

### development

* copy .env-sample to .env
* fill in the webhook url that you found in Hall integration webhook page

### heroku deployment

config the webhook through heroku config

    heroku config:set HALL_WEBHOOK_URL=

### gitlab settings

inside your project settings page, add a web hook with the your heroku repository url. e.g. http://example.herokuapp.com/gitlab/webhook
