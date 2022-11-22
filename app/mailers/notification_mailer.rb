class NotificationMailer < ApplicationMailer
  layout 'mailer'
  def test
    mail(to: "rodolphosnow@gmail.com", cc: "fabianhatori@gmail.com", subject: 'Welcome to My Awesome Site')
  end
  
end
