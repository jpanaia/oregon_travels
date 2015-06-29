# Preview all emails at http://localhost:3000/rails/mailers/blog_mailer
class BlogMailerPreview < ActionMailer::Preview
 def send_mail_preview
    BlogMailer.send_email(Comment.last)
  end
end
