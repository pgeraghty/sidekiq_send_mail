module SidekiqSendMail
  class MailInterceptor
    def self.delivering_email(message)
      unless deliver?(message)
        SidekiqSendMail::Worker.perform_async message.to_yaml
        message.perform_deliveries = false
        puts "Mail routed to Sidekiq (#{message.subject})!"
      end
    end

    def self.deliver?(message)
      defined?(Sidekiq::CLI) #Rails.env.development?
    end
  end
end

