$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..'))

require 'boot'

Bundler.require :default, ENV['RACK_ENV'] if defined?(Bundler) #unless $0 == 'irb'

require 'sidekiq'

# check if running inside Sidekiq worker process
load_workers = defined?(Sidekiq::CLI) || defined?(Sidekiq::Testing) ? true : false

puts "SidekiqSendMail - check if should load worker - #{load_workers}"
if load_workers
  require 'mail'
  Dir[File.expand_path('../../app/**/*.rb', __FILE__)].each { |f| require f }
end

if defined?(ActionMailer)
  require File.expand_path('../../lib/mail_interceptor.rb', __FILE__)
end
