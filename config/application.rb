$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..'))

require 'boot'

Bundler.require :default, ENV['RACK_ENV'] if defined?(Bundler) #unless $0 == 'irb'

require 'sidekiq'