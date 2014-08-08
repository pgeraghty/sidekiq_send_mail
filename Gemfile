source 'http://rubygems.org'

gemspec

rails_version = ENV['RAILS_VERSION'] || 'default'

rails = case rails_version
          when 'master'
            {github: 'rails/actionmailer'}
          when 'default'
            '>= 3.2'
          else
            "~> #{rails_version}"
        end

gem 'actionmailer', rails