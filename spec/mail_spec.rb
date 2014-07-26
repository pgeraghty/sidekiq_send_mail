require 'spec_helper'

describe SidekiqSendMail do
  it 'will allow you to queue deferred mail directly' do
    m = Mail.new do
      to      'mail_testing@test.com'
      from    'Test Sender <testsender@test.com>'
      subject 'Test mail'

      text_part do
        body 'This is plain text'
      end

      html_part do
        content_type 'text/html; charset=UTF-8'
        body '<h1>This is HTML</h1>'
      end
    end

    expect {
      Sidekiq::Client.push 'queue' => 'emails', 'class' => 'SidekiqSendMail::Worker', 'args' => [m.to_yaml]
    }.to change(SidekiqSendMail::Worker.jobs, :size).by(1)
  end

  class UserMailer < ActionMailer::Base
    default from: 'action_mailer_testing@test.com'

    def welcome(email)
      mail(to: email,
           subject: 'Welcome') do |format|
        #format.html { render 'another_template' }
        format.text { render text: 'Content of Welcome Email' }
      end
    end
  end

  it 'will override sending mail with ActionMailer' do
    ActionMailer::Base.register_interceptor(SidekiqSendMail::MailInterceptor)
    expect {
      UserMailer.welcome('user@example.com').deliver
    }.to change(SidekiqSendMail::Worker.jobs, :size).by(1)
    expect(SidekiqSendMail::Worker.jobs.last['queue']).to eq 'emails'
    expect(Mail::TestMailer.deliveries.length).to eq 0
  end

  it 'will send mail when the queue is processed' do
    require 'sidekiq/cli' # usually only required if Sidekiq process is running
    expect {
      SidekiqSendMail::Worker.drain
    }.to change(Mail::TestMailer.deliveries, :length).by(2)
  end
end