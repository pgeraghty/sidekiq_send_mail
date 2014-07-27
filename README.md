# SidekiqSendMail

[![Gem Version](https://badge.fury.io/rb/sidekiq_send_mail.svg)](http://badge.fury.io/rb/sidekiq_send_mail)
[![Build Status](https://travis-ci.org/pgeraghty/sidekiq_send_mail.svg?branch=master)](https://travis-ci.org/pgeraghty/sidekiq_send_mail)
[![Coverage Status](https://img.shields.io/coveralls/pgeraghty/sidekiq_send_mail.svg)](https://coveralls.io/r/pgeraghty/sidekiq_send_mail?branch=master)

Render mail and then send it to a [Sidekiq](http://sidekiq.org/) queue to be sent by a background process.

Other gems typically require you to render emails in background processes. This requires you to load the whole Rails stack and your application plus dependencies. This is an alternative approach that reduces overhead by serializing via Mail::Message#to_yaml.

If sending mail is the only thing you want to in the background then this gem is ideal for that purpose. If you'd like to add fault tolerance and be able to see failures and retry emails, Sidekiq has these features and provides a neat [web interface](https://github.com/mperham/sidekiq/wiki/Monitoring).

# Requirements
SidekiqSendMail has been tested with the latest MRI (2.1.2, 2.0.0) under Rails 3 &amp; 4. 
The ActionMailer component is automatically skipped when not relevant so this gem can be 
used in combination with other frameworks.

Sidekiq requires [Redis](http://redis.io/) 2.4+.

## Installation

Add this line to your application's Gemfile:

    gem 'sidekiq_send_mail'
    
Run Bundler to install the gem:
   
    bundle install


## Usage
### ActionMailer Hooks
Add this line to a new initializer in your application:

    # config/initializers/sidekiq_send_mail.rb
    ActionMailer::Base.register_interceptor(SidekiqSendMail::MailInterceptor)

Ensure Redis is running and your emails will now be queued via Sidekiq.

To perform this only in production/staging, you can use:

    ActionMailer::Base.register_interceptor(SidekiqSendMail::MailInterceptor) if %w(staging production).include?(Rails.env)
    
## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
