module SidekiqSendMail
  class Worker
    def perform(mail_yaml)
      m = ::Mail::Message.from_yaml mail_yaml
      m.deliver
      # TODO check m.retryable?, set retry appropriately
    end
  end
end

