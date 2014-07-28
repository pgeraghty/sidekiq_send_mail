# SidekiqSendMail

[![Gem Version](https://badge.fury.io/rb/sidekiq_send_mail.svg)](http://badge.fury.io/rb/sidekiq_send_mail)
[![Build Status](https://travis-ci.org/pgeraghty/sidekiq_send_mail.svg?branch=master)](https://travis-ci.org/pgeraghty/sidekiq_send_mail)
[![Coverage Status](https://img.shields.io/coveralls/pgeraghty/sidekiq_send_mail.svg)](https://coveralls.io/r/pgeraghty/sidekiq_send_mail?branch=master)
[![Code Climate](https://codeclimate.com/github/pgeraghty/sidekiq_send_mail.png)](https://codeclimate.com/github/pgeraghty/sidekiq_send_mail)

#### Render mail, serialize it and then send it to a [Sidekiq](http://sidekiq.org/) queue for dispatch by a background process.

## Why use this?
* Other gems typically require you to render emails in background processes. This requires you to load the whole Rails 
  stack and your application plus dependencies. This is an alternative approach that reduces overhead by 
  serializing via [Mail::Message#to_yaml](https://github.com/mikel/mail/blob/master/lib/mail/message.rb#L1828).

* One SidekiqSendMail process can serve many applications, you do not need one for each.

* If you'd like to add fault tolerance and be able to see failures and retry emails, Sidekiq has these features and 
  provides a neat [web interface](https://github.com/mperham/sidekiq/wiki/Monitoring).

If sending mail is the only thing you want to do in the background then this gem is ideal for that purpose. 

## Requirements
SidekiqSendMail has been tested with the latest MRI (2.1.2, 2.0.0) under Rails 3 &amp; 4. 
The ActionMailer component is automatically skipped when not relevant so this gem can be 
used in combination with other frameworks.

Sidekiq requires [Redis](http://redis.io/) 2.4+.

## Installation

Add this line to your application's Gemfile:
```ruby   
gem 'sidekiq_send_mail'
```
    
Run Bundler to install the gem:
```shell   
bundle install
```

## Usage
### Rails (via ActionMailer Hooks)
Create a new initializer `config/initializers/sidekiq_send_mail.rb`  in your application containing:

```ruby
ActionMailer::Base.register_interceptor(SidekiqSendMail::MailInterceptor)
```

Ensure Redis is running and your emails will now be queued via Sidekiq.

To perform this only in production/staging, you can use:

```ruby
ActionMailer::Base.register_interceptor(SidekiqSendMail::MailInterceptor) if %w(staging production).include?(Rails.env)
```

### Starting Sidekiq
To actually send the emails you've queued, you need to start Sidekiq. 
An executable is provided with this gem for basic operation, open a terminal and execute:

```shell  
sk_send_mail
```
    
This initiates a barebones Sidekiq process bound to the 'emails' queue with a concurrency of 1 and a shutdown timeout of 20s.

To shut down this process, you use the command:

```shell
sidekiqctl shutdown /tmp/sidekiq-emails.pid
```

See the [source](https://github.com/pgeraghty/sidekiq_send_mail/blob/master/bin/sk_send_mail) or the 
[Sidekiq wiki](https://github.com/mperham/sidekiq/wiki/Advanced-Options) for more information.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

MIT: <http://pg.mit-license.org>