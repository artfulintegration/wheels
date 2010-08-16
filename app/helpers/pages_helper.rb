module PagesHelper
  def include_ckeditor
    content_for :head do
      javascript_include_tag('/ckeditor/ckeditor.js',
        '/ckeditor/adapters/jquery.js',
        "galleries/configure_ckeditor.js")
    end
  end

end

