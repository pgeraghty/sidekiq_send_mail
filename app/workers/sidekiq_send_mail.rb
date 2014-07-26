module SidekiqSendMail
  class Worker
    include Sidekiq::Worker
    sidekiq_options queue: :emails, retry: 0, backtrace: true

    sidekiq_retry_in do |count|
      60 * 1440 * 30 # 30 days
    end

    def perform(mail_yaml)
      m = ::Mail::Message.from_yaml mail_yaml
      m.deliver
      # TODO check m.retryable?, set retry appropriately
    end
  end
end

