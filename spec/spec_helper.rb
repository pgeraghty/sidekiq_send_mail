require 'sidekiq'

require 'sidekiq/testing'
Sidekiq::Testing.fake!

require 'action_mailer'
ActionMailer::Base.delivery_method = :test

require 'sidekiq_send_mail'
Mail.defaults do
  delivery_method :test
end