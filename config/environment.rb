ENV['RACK_ENV'] ||= ENV['RAILS_ENV'] || 'development' # RACK_ENV is set by -e param for sidekiq

require File.expand_path('../application', __FILE__)