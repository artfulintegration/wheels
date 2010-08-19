module PagesHelper
  def form_url
    @parent_page ? page_children_path(@parent_page) : page_path(@page)
  end
  def form_object
    @parent_page ? [@parent_page, @page] : @page
  end

  def to_html_options(pages)
    pages.map{|p| [p.title, p.id]}
  end
end

