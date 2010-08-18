class AccessControlEntriesController < InheritedResources::Base
  ajax_loading
  before_filter :authenticate_user!
  belongs_to :user, :optional => true
  has_scope :by_resource, :using => [:resource_class, :resource_id]
  has_scope :by_role, :using=>[:role_id]
  has_scope :by_class, :using=>[:class]
  respond_to :html, :js

  def new_ace
    a = AccessControlEntry.new
    a.user_id = params[:user_id]
    a.role_id = params[:role_id]
    a.resource_class_name = params[:resource_class]
    a.options[:id] = params[:resource_id]
    return a
  end
  helper_method :new_ace
end

