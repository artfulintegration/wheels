module ActionViewHelperExtensions
  def super_user
    @@super_user ||= User.where(:role_id=>Role.find_by_name("Super").id).first
  end
end

ActionController::Base.send :include, ActionViewHelperExtensions
ActionController::Base.helper_method :super_user

