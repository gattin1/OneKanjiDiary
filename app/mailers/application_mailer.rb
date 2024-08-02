# frozen_string_literal: true

# ApplicationMailerはすべてのメールクラスのベースクラスです。
class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
end
