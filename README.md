StatusDashboard
===============

StatusDashboard provides a pre-built application to display application status and health for applications that use NewRelic RPM.  It uses ActiveAdmin to provide an administration interface for admin users to post messages that will be rendered into HTML from markdown syntax by RDiscount and displayed on the main facing page.

Through the use of .yml configutation files, NewRelic and Hoptoad API access is done for you.

Installation
============

First you will need a sandbox Rails environment

`rails new [MyAppName]`

Add the following to your Gemfile

    gem 'status_dashboard', :git => 'git@github.com:minustehbare/status_dashboard.git'
    gem 'activeadmin'

Install the newly added gems

`bundle install`

Now it's time to generate ActiveAdmin and StatusDashboard

    rails g active_admin:install
    rails g status_dashboard:install

You will be prompted about overwriting the default `app/admin/dashboards.rb` file.  Confirm the overwrite and move on.  Migrate the database

`rake db:migrate`

Hoptoad API access is optional, though NewRelic API access is required.  As such, you will need to modify the `config/newrelic_api.yml` file and define the values or bad things will happen.

The Hoptoad config file is created for you with two default values.  The `auth_token` and `site_url` you must supply in order for error retrieval to work.  Locate the `config/hoptoad_api.yml` file and modify it accordingly if you want to retrieve Hoptoad errors.

The URL is the one used by Hoptoad (e.g. https://your_app_name.hoptoadapp.com) and the error frequency defines a minimum threshold of occurrence before the error is deemed 'important' enough to display to your users.  For the expiry time, it defines how long the cache will hold on to the cached errors before accessing the Hoptoad API for an updated collection.

Lastly, remove the pesky default root view and boot your server

    rm public/index.html
    rails s

This set of instructions 'registers' the Post model with ActiveAdmin for use in the admin interface.  It also generates a _very_ generic root view to display Posts made, Hoptoad errors, and a color-indicator for the health of your application according to NewRelic.  To make your life easier, the root view is automatically created in your application so you can override it from the start.

The StatusController retrieves your account through the NewRelicApi and leaves the rest to you: choosing which application to display status for and how to gauge its status (by response time, apdex, etc.).  Take a look at the [NewRelicApi](https://github.com/newrelic/newrelic_api) for more information.

As a final note, NewRelic restricts you to only being able to request app status every one minute.  To bypass unnecessary external requests to both Hoptoad and NewRelic, the results from the request are cached with an expiry time.  You will need to have some sort of cache client that supports cache expiration unless you want static results.

Customizing
===========

Without enumerating all possibilities for customization, there are a few that could make your life easier and the status dashboard you create softer on the eyes.

***Pagination***

A first choice is the paginate the Posts displayed on the root view.  Add to your Gemfile:

`gem 'will_paginate', '~> 3.0.pre2'`

`bundle install` and eval the Post model to define the number of Posts per page:

    Post.class_eval do
      cattr_reader :per_page
      @@per_page = 5
    end

Then use the will_paginate helpers in the root view:

    <% @posts.each do |p| %>
      <%= post_body_to_html p %><br />
    <% end %>
    <%= page_entries_info @posts %>
    <%= will_paginate @posts %>

***Paperclip and Images***

You could also tag Posts with images and use an image scroller for users to select Posts.  Add paperclip to your Gemfile:

`gem 'paperclip', '~> 2.3'`

`bundle install` and eval the Post model

    Post.class_eval do
      has_attached_file :image, :styles => { :mini => '48x48>', :thumbnail => '256x256>' }
    end

Have fun with the styles and sizes.  You will also need to tell ActiveAdmin how to handle the forms to create and edit Posts correctly.  In `app/admin/posts.rb` do the following (or something similar):

    form :html => { :multipart => true } do |f|
      f.inputs 'Post Details' do
        f.input :title
        f.input :body, :as => :text
        f.input :image, :as => :file
      end
      f.buttons
    end

And you should be all set to attach images to Posts.

***Styling***

Don't forget to add some CSS styling.  The plain HTML is, well, plain.  The root view is just a baseline, you're free to modify it however you would like and use the ID's and classes for CSS selectors to style.

Copyright (c) 2011 minustehbare, released under the New BSD License
