$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..'))

require 'boot'

Bundler.require :default, ENV['RACK_ENV'] if defined?(Bundler) #unless $0 == 'irb'

require 'sidekiq'

# check if running inside Sidekiq worker process
load_workers = !!defined?(Sidekiq::CLI)

puts "SidekiqSendMail - check if should load worker - #{load_workers}"
SidekiqSendMail::enable_worker! if load_workers

if defined?(ActionMailer)
  require File.expand_path('../../lib/mail_interceptor.rb', __FILE__)
end
