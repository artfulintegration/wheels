class Sitemap < ActiveRecord::Base
  after_create :create_resource
  after_save :reload_root
  alias_attribute :name, :menu_text
  before_destroy :on_before_destroy
  belongs_to :parent, :class_name=>'Sitemap', :foreign_key=>'parent_id'
  belongs_to :resource, :polymorphic => true
  has_many :access_control_entries, :as => :resource
  has_many :children, :class_name=>'Sitemap', :foreign_key=>'parent_id', :dependent => :destroy do
    def sorted
      sort{|t, u| if t.nil? || t.position.nil?; 1;
                  elsif u.nil? || u.position.nil?; -1;
                  else t.position <=> u.position end}
    end
  end
  accepts_nested_attributes_for :children
  scope :orphans, where(:parent_id=>nil).where("menu_text <> 'root'")
  validates :resource, :presence=>true

  def as_json(*a)
    {
      :position=>self.position,
      :data=>{
        :title=>self.menu_text,
        :icon=>icon_name,
      },
      :attr=>{
        :id=>"node_#{id}",
        :rel=>resource_type.underscore,
        :data_menu_text => self.menu_text,
        :data_resource_type => self.resource_type,
        :data_resource_id => self.resource_id,
        :data_id => self.id
      },
      :state=>treeview_state,
      :children=> children.sorted
    }.as_json(*a)
  end

  def resource_attributes=(attrib={})
    raise "Cant build resource without resource_type" if resource_type.empty?
    resource = create_resource
    resource.attributes = attrib
    resource.save
  end

  def url
    if self == Sitemap.main_menu
      '/'
    elsif resource.is_a? ExternalLink
      resource.url
    else
      %(#{(a=parent.url)=='/'?'':a}/#{menu_text.gsub(/ /, '_')})
    end
  end

  #  Callbacks
  def self.reload_root
    Sitemap.instance_variable_set('@_root', nil)
  end

  def reload_root
    Sitemap.reload_root
  end

  def on_before_destroy
    resource.destroy if resource && resource.sitemaps.size==1
  end

  def create_resource
    if self.resource_type && !self.resource_id
      self.resource = resource_type.constantize.new
      self.save
    end
  end

  #########################################################################
  #
  # Class Methods
  #
  #########################################################################

  def self.from_request_params(params)
    puts params.slice(:level1, :level2, :level3, :level4).values.inspect + "\n"*30
    find_by_path params.slice(:level1, :level2, :level3, :level4).values
  end

  def self.lost_and_found
    root.children.select{|t| t.menu_text=='Lost + Found'}[0]
  end

  def self.main_menu
    root.children.select{|t| t.menu_text=='Main Menu'}[0]
  end

  def self.root
    @_root ||= Sitemap.find_by_menu_text_and_parent_id('root', nil)
  end

  def self.new_main_menu_page(name)
    Sitemap.create( :parent=>self.main_menu,
                    :menu_text=>name,
                    :resource=>Page.create(:title=>name),
                    :position=>Sitemap.main_menu.children.count)
  end

  def self.settings
    root.children.select{|t| t.menu_text=='Settings'}[0]
  end

  #########################################################################
  #
  # Private Methods
  #
  #########################################################################
  def self.find_by_path(*path_args)
    path_args.flatten!
    path = path_args.reverse
    path.delete(nil)
    obj = Sitemap.main_menu
    while (path_piece=path.pop)
      obj = obj.children.select{|t| t.menu_text.downcase==path_piece.downcase.gsub(/_/, ' ')}[0]
      break unless obj
    end
    return obj
  end


  private
  def build_resource(params={})
    if resource_class
      a = resource_class.new(params)
      self.resource = a
      a
    end
  end

  def create_resource(params={})
    if resource_class
      a = resource_class.create(params)
      self.resource = a
      a
    end
  end

  def icon_name
    case resource_type
    when "Page"
      "page"
    when "ExternalLink"
      "folder"
    when "Menu"
      "drive"
    end
  end

  def new_model
    resource_class.new(:sitemaps=>[self]) if resource_class
  end

  def resource_class
    resource_type.camelize.constantize unless resource_type.empty?
  end

  def treeview_state
    if resource.is_a?(Menu)
      "open"
    elsif resource.is_a? Page
      "closed"
    else
      "open"
    end
  end
end

class SitemapArray < Array
  def to_json
    "[" + map(&:to_json).join(",") + "]"
  end
end

