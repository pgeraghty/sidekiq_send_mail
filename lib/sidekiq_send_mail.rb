$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'config'))
require File.expand_path('../../config/environment', __FILE__)

module SidekiqSendMail
end
