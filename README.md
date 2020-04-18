# README

A simple and entiely unofficial Rails app which I've cobbled together as a demo of the authentication process for the FreeAgent API. It allows you to go through the full OAuth flow, refresh your tokens and try out some sample endpoints (at the moment of writing, only GET requests are supported).

## Installation instructions

* Ensure you have Ruby 2.7.1 installed
* Clone the repo with `git clone git@github.com:elipinska/freeagent-api-demo.git`
* Navigate to the repo `cd freeagent-api-demo`
* Install dependencies with `bundle install`
* Set up the database: `bin/rails db:setup && bin/rails db:migrate`
* Start the server: `bin/rails s`

In order to be able to authenticate with the FreeAgent API, you'll need an app registered on the FreeAgent Developer Dashboard and a sandbox FreeAgent account. Instructions on how to set these up can be found at https://dev.freeagent.com/docs/quick_start.

After you've registered on the Developer Dashboard, you'll be given a client id and secret which this demo app will expect to be able to retrieve from your environment variables. To export them, run:

```
export FA_API_CLIENT_ID="YOUR_CLIENT_ID"
export FA_API_CLIENT_SECRET="YOUR_CLIENT_SECRET"
```

Finally, you'll need a redirect URL which FreeAgent will use to send you back to the demo app:

```
export FA_API_REDIRECT_URL="http://localhost:<PORT_NUMBER>/auth/freeagent/callback"
```

Alternatively, you can edit these configs directly in `config/environments/development.rb`
