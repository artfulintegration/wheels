class PagesController < InheritedResources::Base
  before_filter :resource, :only=>[:update, :show, :destroy, :edit]
  authorize_resource
  has_scope :tagged_with, :as => :tag
  has_scope :accessible_by, :type=>:boolean, :default=>true do |c,s|
    s.accessible_by(c.current_ability)
  end

  def resource
    page_id = params[:id]
    if page_id.is_numeric?
      @page ||= Page.find(page_id)
    else
      @page ||= Page.where(["lower(pages.title) = ?", page_id.downcase.gsub(/[_]/, ' ')]).first
    end
  end
end

