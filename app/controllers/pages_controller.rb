class PagesController < InheritedResources::Base
  def resource
    page_id = params[:id] || Layout.current[:default_page]
    if page_id.is_numeric?
      @page ||= Page.find(page_id)
    else
      @page ||= Page.where(["pages.title.tolower() = ?", page_id.downcase])
    end
  end
end

