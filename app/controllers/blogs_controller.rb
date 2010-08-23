class BlogsController < InheritedResources::Base
  before_filter :load_maybe
  belongs_to :user, :optional => true
  has_scope :tagged_with, :as => :tag
  helper_method :tags
  respond_to :html, :xml


  def load_maybe
    unless params[:user_id]
      @user = (current_user || User.root)
    end
  end

  def tags
    @tags ||= Blog.where(:user_id=>@user.id).tag_counts.sort{|t, u| t.count <=> u.count}
  end

  def collection
    @blogs ||= Blog.where(:user_id=>@user.id).
      paginate(:page => params[:page], :order => 'created_at DESC' )
  end

  before_filter :authenticate_user!, :except=>[:show, :index]
#  before_filter :maybe_authenticate, :only=>[:show, :index]
  before_filter :resource, :only=>[:update, :show, :destroy, :edit]
  authorize_resource

  def maybe_authenticate
    unless user_signed_in?
      authenticate_user! unless current_ability.can? :read, resource
    end
  end
end

