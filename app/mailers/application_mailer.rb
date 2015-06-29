class ApplicationMailer < ActionMailer::Base
  # default from: "from@example.com"
  # layout 'mailer'
  def welcome_email(user)
  	@user  = user
  	@url = 'http://oregontrail.herokuapp.com'
  	mail(to: @user.email, subject: 'Welcome to Oregon Trail!')
  end
end
