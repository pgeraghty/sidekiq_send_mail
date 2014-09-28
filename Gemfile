source 'http://rubygems.org'

gemspec

rails_version = ENV['RAILS_VERSION'] || 'default'

if rails_version == 'master'
  gem 'rails', github: 'rails/rails'
else
  rails =
      case rails_version
        when 'default'
          '>= 3.2'
        else
          "~> #{rails_version}"
      end

  gem 'actionmailer', rails
end

sidekiq_version = ENV['SIDEKIQ_VERSION'] || 'default'

sidekiq = case sidekiq_version
          when 'master'
            {github: 'mperham/sidekiq'}
          when 'default'
            ['>= 3.0', '< 3.3']
          else
            "~> #{sidekiq_version}"
        end

gem 'sidekiq', sidekiq

