module ApplicationHelper
  def menu_item(name, href)
    content_tag(:li, content_tag(:a, content_tag(:span, name), :href=>href))
  end
  def include_ckeditor
    content_for :head do
      javascript_include_tag('/ckeditor/ckeditor.js',
        '/ckeditor/adapters/jquery.js',
        "galleries/configure_ckeditor.js")
    end
  end
end

