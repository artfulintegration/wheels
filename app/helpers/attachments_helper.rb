module AttachmentsHelper
  def make_session_string
    arr = []
    request.env['HTTP_COOKIE'].each_char{|c| arr.push(c[0].to_s)}
    arr.join("x")
  end

  def session_key_name
    Rails.application.config.session_options[:key]
  end
end

