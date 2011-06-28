StatusDashboard
===============

StatusDashboard provides a pre-built application to display application status and health for applications that use NewRelic RPM.  It uses ActiveAdmin to provide an administration interface for admin users to post messages that will be rendered into HTML from markdown syntax by RDiscount and displayed on the main facing page.

Through the use of .yml configutation files, NewRelic and Hoptoad API access is done for you.

Installation
============

First you will need a sandbox Rails environment

`rails new [MyAppName]`

Add the following to your Gemfile

`gem 'status_dashboard', :git => 'git@github.com:minustehbare/status_dashboard.git'
gem 'activeadmin'`

Install the newly added gems

`bundle install`

Now it's time to generate ActiveAdmin and StatusDashboard

`rails g active_admin:install`
`rails g status_dashboard:install`

You will be prompted about overwriting the default `app/admin/dashboards.rb` file.  Confirm the overwrite and move on.  Migrate the database

`rake db:migrate`

Hoptoad API access is optional, though NewRelic API access is required.  As such, you will need to create a `config/newrelic_api.yml` file and define it like so

    newrelic_api:
      api_key: [your_api_key]
      account_id: [your_account_id]

If you want to take advantage of display Hoptoad errors to your users, do something similar for a `config/hoptoad_api.yml` file

    hoptoad_api:
      auth_token: [your_auth_token]
      site_url: [your_site_url]
      error_frequency_minimum: [minimum_error_occurrence]

The URL is the one used by Hoptoad (e.g. https://<app_name>.hoptoadapp.com) and the error frequency defines a minimum threshold of occurrence before the error is deemed 'important' enough to display to your users.

Lastly, remove the pesky default root view and boot your server

`rm public/index.html`
`rails s`

This set of instructions 'registers' the Post model with ActiveAdmin for use in the admin interface.  It also generates a _very_ generic root view to display Posts made, Hoptoad errors, and a color-indicator for the health of your application according to NewRelic.  To make your life easier, the root view is automatically created in your application so you can override it from the start.

Customizing
===========

Incoming.

Copyright (c) 2011 minustehbare, released under the New BSD License
