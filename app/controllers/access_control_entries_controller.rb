class AccessControlEntriesController < InheritedResources::Base
  ajax_loading
  before_filter :authenticate_user!
  belongs_to :sitemap, :page, :forum, :user, :role, :polymorphic => true, :optional=>true
  has_scope :by_role, :using=>[:role_id]
  has_scope :by_class, :using=>[:class]
  respond_to :html, :js

  def create
    parent = params.slice(:sitemap_id, :page_id, :forum_id, :user_id, :role_id).
                    to_a[0]
    parent = parent[0].gsub(/_id/, '').camelize.constantize.find(parent[1]) if parent
    @access_control_entry = parent.access_control_entries.create(params[:access_control_entry])
    respond_with @access_control_entry
  end

  def new_ace
    a = AccessControlEntry.new
    a.user_id = params[:user_id]
    a.role_id = params[:role_id]
    a.resource_type = case true
      when params.include?(:sitemap_id) then "Sitemap"
      when params.include?(:page_id) then "Page"
      when params.include?(:forum_id) then "Forum"
      else nil
    end
    return a
  end

  def sort
    order = params[:ids]
    parent.access_control_entries.
    Image.order(order)
    render :text => order.inspect
  end
  helper_method :new_ace
end

