# SidekiqSendMail

Render mail and then send it to a Sidekiq queue to be sent by a background process.

Other gems typically require you to render emails in background processes. This requires you to load the whole Rails stack and your application plus dependencies. This is an alternative approach that reduces overhead by serializing via Mail::Message#to_yaml.

If sending mail is the only thing you want to in the background then this gem is ideal for that purpose.

## Installation

Add this line to your application's Gemfile:

    gem 'sidekiq_mailer'


## Usage - ActionMailer Hooks

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
