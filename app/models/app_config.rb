class AppConfig < ActiveRecord::Base
  has_many :sitemaps, :as=>:resource
  after_save :reload

  before_create :set_name

  def self.[](name)
    val = select{|t| t.name==name}[0].try(:value)
    if val && (val==val.to_i.to_s)
      val = val.to_i
    end
    val
  end

  def self.current
    @current ||= AppConfig.all
  end
  def reload
    AppConfig.instance_variable_set '@current', nil
  end

  def set_name
    self.name = sitemaps[0].try(:menu_text) unless self.name
  end
end

