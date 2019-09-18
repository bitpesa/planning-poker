# README

Planning poker app for slack, accessible with /poker in engineering.

Some functionality still needed:

- Zero needed to be added as a choice
- Error handling for unhappy paths
- Display the poker session name and average vote on a new line after completing
- Functionality to vote in days for timeboxing as well
- Allow usage in any channel and not just `#engineering`

## Installation

The application runs under our heroku instance. To install into Slack please do the following:

1. Create a new Slack Application under https://api.slack.com/apps?new_app=1
2. Once created add a new slash command with the following details:

  - Command: `/poker`
  - Request URL: `https://bitpesa-planning-poker.herokuapp.com/poker_sessions`
  
3. Activate incoming webhooks for the app, and create a new webhook that posts to the `#engineering` channel
4. Obtain the webhook URL, and change the heroku `SLACK_HOOK_URL` environment variable to point to that URL
5. Also enable Interactive Components, with the follwoing settings:

   - Request URL: `https://bitpesa-planning-poker.herokuapp.com/estimates`
