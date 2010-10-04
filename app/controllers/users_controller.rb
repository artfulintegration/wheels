class UsersController < InheritedResources::Base
  respond_to :html, :js, :only=>[:edit, :show, :update, :change_password]
  respond_to :json, :only=>[:verify_password]

  before_filter :authenticate_user!, :resource

  def edit
    respond_with(resource)
  end

  def update
    if params[:commit] == "Update Account"
      @user = User.find(params[:id])
      update! do |success, failure|
        failure.html{redirect_to my_account_path}
        success.html{flash[:notice] = "Your account has been updated."; redirect_to root_url}
      end
    else
      @user = User.find(params[:id])
      @user.password = params[:user]["password"]
      @user.save
      flash[:notice] = "Your password has been changed."
      redirect_to root_url
    end
  end

  def verify
    respond_with resource do |format|
      format.json {render :json=> resource.valid_password?(params[:password]).to_json}
    end
  end

  def resource
    @user ||= FullyValidatedUser.find(current_user)
  end
end

