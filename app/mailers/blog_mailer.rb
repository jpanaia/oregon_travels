class BlogMailer < ApplicationMailer
 default from: "oregontrailgirls15@gmail.com"

  def send_email(comment)
  	@comment = comment
  	mail(to: 'oregontrailgirls15@gmail.com', subject: 'A New Comment Has Been Created!')
  end
end
