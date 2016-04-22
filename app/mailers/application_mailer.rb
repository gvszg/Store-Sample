class ApplicationMailer < ActionMailer::Base
  default from: "service@kosbrother.com", css: :admin
  layout 'mailer'
end