class BlogsController < InheritedResources::Base
  respond_to :html, :xml
  belongs_to :user, :optional=>true
  before_filter :load_current_user

  def collection
    @blogs ||= end_of_association_chain.
      paginate(:page => params[:page], :order => 'created_at DESC' )
  end

  def load_current_user
    unless params[:user_id]
      @user ||= (current_user ? User.find(current_user.id) : super_user)
    end
  end
end

