class ExternalLink < ActiveRecord::Base
  has_many :sitemaps, :as=>:resource

  after_save :reload_sitemap

  def reload_sitemap
    Sitemap.reload_root
  end
end

