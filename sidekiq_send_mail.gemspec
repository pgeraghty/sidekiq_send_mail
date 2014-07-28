# Add to load path
$:.push File.expand_path('../lib', __FILE__)

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'sidekiq_send_mail'
  s.version     = '0.1.1'
  s.authors     = ['Paul Geraghty']
  s.email       = 'muse@appsthatcould.be'
  s.homepage    = 'https://github.com/pgeraghty/sidekiq_send_mail'
  s.summary     = 'SidekiqSendMail'
  s.description = 'Render mail, serialize it and then send it to a Sidekiq queue for dispatch by a background process.'
  s.license     = 'MIT'

  s.files = Dir['{app,bin,config,lib,test}/**/*'] + %w(Gemfile Rakefile sidekiq_send_mail.gemspec) # MIT-LICENSE Rakefile README.md
  #s.test_files = Dir['spec/**/*']
  s.executables << 'sk_send_mail'

  s.add_dependency 'sidekiq', '>= 3.0', '< 3.3'
  s.add_dependency 'mail', '>= 2.5.4', '< 2.7'

  s.add_development_dependency 'rake', '>= 0'
  s.add_development_dependency 'rspec', '>= 0'
  s.add_development_dependency 'rails', '>= 3.2'
  s.add_development_dependency 'coveralls', '>= 0'
end
