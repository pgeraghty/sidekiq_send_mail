# Add to load path
$:.push File.expand_path('../lib', __FILE__)

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'sidekiq_send_mail'
  s.version     = '0.0.5'
  s.authors     = ['Paul Geraghty']
  s.email       = %w(muse@appsthatcould.be)
  #s.homepage    = 'https://github.com/pgeraghty/sidekiq_send_mail'
  s.summary     = 'SidekiqSendMail'
  s.description = 'Send mail with Sidekiq with or without Rails - can be run as a standalone daemon.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,lib}/**/*'] + %w(config.ru Gemfile sidekiq_send_mail.gemspec) # MIT-LICENSE Rakefile README.md

  s.add_dependency 'sidekiq', '>= 3.0', '< 3.3'
  s.add_dependency 'mail', '>= 2.5.4', '< 2.7'

  s.add_development_dependency 'rake', '>= 0'
  s.add_development_dependency 'rspec', '>= 0'
  s.add_development_dependency 'rails', '>= 3.2'
end
