class FeedbackMailer < ActionMailer::Base
  default :from => "mailer-no-reply@cagym.com"

  def submit_feedback(feedback)
    @feedback = feedback
    #attachments["rails.png"] = File.read("#{Rails.root}/public/images/rails.png")
    mail(:to => "hipkin@pacbell.net", :subject => %(CAGYM.com user feedback: #{feedback.subject}))
  end
end

