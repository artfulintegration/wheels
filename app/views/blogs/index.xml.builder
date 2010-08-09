xml.instruct!

xml.feed "xmlns" => "http://www.w3.org/2005/Atom" do

  xml.title   "Feed Name"
  xml.link    "rel" => "self", "href" => user_blogs_path(@user, :only_path=>false, :format=>:xml)
  # xml.link    "rel" => "alternate", "href" => url_for(:only_path => false, :controller => 'posts')
  xml.id      user_blogs_path(@user, :only_path => false)
  xml.updated @blogs.first.updated_at.strftime "%Y-%m-%dT%H:%M:%SZ" if @blogs.any?
  xml.author  { xml.name @blogs.first }

  @blogs.each do |post|
    xml.entry do
      xml.title   post.title
      xml.link    "rel" => "alternate", "href" => user_blogs_path(@user, post, :only_path => false)
      xml.id      user_blog_path(@user, post, :only_path => false)
      xml.updated post.updated_at.strftime "%Y-%m-%dT%H:%M:%SZ"
      xml.author  { xml.name post.user.email }
      xml.summary "Post summary"
      xml.content "type" => "html" do
        xml.cdata! post.body
      end
    end
  end

end

