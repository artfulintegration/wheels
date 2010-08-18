class DiscussionsController < InheritedResources::Base
  belongs_to :forum

  def new
    new! do |format|
      @new_message = ForumMessage.new(:discussion=>resource, :author=>current_user)
    end
  end
end

