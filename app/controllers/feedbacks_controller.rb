class FeedbacksController < InheritedResources::Base
  def create
    create! do |format|
      FeedbackMailer.submit_feedback(@feedback).deliver
      flash[:notice] = "Thanks for your feedback!"
      format.html { redirect_to "/" }
    end
  end
end

