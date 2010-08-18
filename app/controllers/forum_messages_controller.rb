class ForumMessagesController < InheritedResources::Base
  belongs_to :forum, :discussion

  resource_attributes({:author => :current_user})

  def create
    create! {forum_discussion_path(@discussion.forum, @discussion)}
  end
  def update
    update! {forum_discussion_path(@discussion.forum, @discussion)}
  end
end

