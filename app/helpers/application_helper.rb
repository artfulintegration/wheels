module ApplicationHelper
  def menu_node(name, url)
    content_tag(:li, content_tag(:a, content_tag(:span, name, :class=>name.underscore.gsub(/ /, '_')), :href=>url))
  end

  def sidebar_link(name, url, is_title = false)
    _class = name.underscore.gsub(/ /, '_')
    _class += "sidebar_title" if is_title
    content_tag(:li, content_tag(:a, content_tag(:span, name, :class=>name.underscore), :href=>url), :class=>_class)
  end

  def sidebar_content(&block)
    @sidebar = true
    content_for(:sidebar) do
      block.call
    end
  end

  def nav_content(&block)
    @sidebar = true
    content_for(:navigation) do
      block.call
    end
  end

  def include_ckeditor
    content_for :head do
      javascript_include_tag('/ckeditor/ckeditor.js',
        '/ckeditor/adapters/jquery.js',
        "galleries/configure_ckeditor.js")
    end
  end
  def session_key_name
    Rails.application.config.session_options[:key]
  end
  def make_session_string
    arr = []
    request.env['HTTP_COOKIE'].each_char{|c| arr.push(c[0].to_s)}
    arr.join("x")
  end

end

