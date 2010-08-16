class BlogsController < InheritedResources::Base
  respond_to :html, :xml
  before_filter
  has_scope :tagged_with, :as => :tag
  belongs_to :user, :optional => true

  def collection
    @blogs ||= end_of_association_chain.
      paginate(:page => params[:page], :order => 'created_at DESC' )
  end

  def begin_of_association_chain
    @user ||= (current_user ? User.find(current_user.id) : super_user)
    @tags = Blog.where(:user_id=>@user.id).tag_counts.sort{|t, u| t.count <=> u.count}
    return @user
  end
end

