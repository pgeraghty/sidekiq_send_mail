$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'config'))
require File.expand_path('../../config/environment', __FILE__)

module SidekiqSendMail
  # Stub out this worker for queuing and testing purposes
  class Worker
    include Sidekiq::Worker
    sidekiq_options queue: :emails, retry: 0, backtrace: true

    sidekiq_retry_in do |count|
      60 * 1440 * 30 # 30 days
    end
  end

  def self.enable_worker!
    require 'mail'
    Dir[File.expand_path('../../app/**/*.rb', __FILE__)].each { |f| require f }
  end
end

# check if running inside Sidekiq worker process
load_workers = !!defined?(Sidekiq::CLI)

puts "SidekiqSendMail - check if should load worker - #{load_workers}"
SidekiqSendMail::enable_worker! if load_workers

if defined?(ActionMailer)
  require File.expand_path('../../lib/mail_interceptor.rb', __FILE__)
end

