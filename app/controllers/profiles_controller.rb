class ProfilesController < InheritedResources::Base
  respond_to :html
  before_filter :load_current_user
  belongs_to :user, :optional => true, :singleton=>true

  def load_current_user
    unless params[:user_id]
      @user ||= (current_user ? User.find(current_user.id) : User.super_user)
    end
  end

  def resource
    @profile ||= Profile.find_by_user_id(@user.id)
  end
end

