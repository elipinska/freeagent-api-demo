# README

A simple and entirely unofficial Rails app which I've cobbled together as a demo of the authentication process for the FreeAgent API. It allows you to go through the full OAuth flow, refresh your tokens and try out some sample endpoints (at the moment of writing, only GET requests are supported).

![alt text](https://github.com/elipinska/freeagent-api-demo/blob/master/readme-images/screenshot.png "Authentication page")

## Installation instructions

* Ensure you have Ruby 2.7.1 installed
* Clone the repo with `git clone git@github.com:elipinska/freeagent-api-demo.git`
* Navigate to the repo `cd freeagent-api-demo`
* Install dependencies with `bundle install`
* Set up the database: `bin/rails db:setup && bin/rails db:migrate`
* Start the server: `bin/rails s`

In order to be able to authenticate with the FreeAgent API, you'll need an app registered on the FreeAgent Developer Dashboard and a sandbox FreeAgent account. Instructions on how to set these up can be found at https://dev.freeagent.com/docs/quick_start.

After you've registered a new app on the Developer Dashboard, you'll be given a client id and secret which this demo app will expect to be able to retrieve from your environment variables. To export them, run:

```
export FA_API_CLIENT_ID="YOUR_CLIENT_ID"
export FA_API_CLIENT_SECRET="YOUR_CLIENT_SECRET"
```

Finally, you'll need a redirect URL which FreeAgent will use to send you back to the demo app after you've approved access to your sandbox account:

```
export FA_API_REDIRECT_URL="http://localhost:<PORT_NUMBER>/auth/freeagent/callback"
```

The same URL should also be added to the app you've created on the Developer Dashboard under `OAuth redirect URIs`.

Alternatively, you can edit these configs directly in `config/environments/development.rb`

## How to use

Once you've authenticated with the API, you'll be able to add endpoints you'd like to be able to query.
A few (`/v2/company`, `v2/users/me` and `/v2/invoices`) have already been added to the database seeds for you to get you started!

## Credits

Icons made by <a href="https://www.flaticon.com/authors/eucalyp" title="Eucalyp">Eucalyp</a> and <a href="https://www.flaticon.com/authors/freepik" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/" title="Flaticon"> www.flaticon.com</a>
