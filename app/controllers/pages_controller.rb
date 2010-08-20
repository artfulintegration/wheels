class PagesController < InheritedResources::Base
  respond_to :js, :html
  ajax_loading
  belongs_to :parent, :optional=>true, :collection_name => :children,
             :parent_class=>Page, :param=>:page_id, :instance_name=>:parent_page
  before_filter :set_collection_name

  def set_collection_name
    if params[:page_id]
      self.resources_configuration[:self][:collection_name] = :children
    end
  end

  before_filter :authenticate_user!, :except=>[:show]
  before_filter :maybe_authenticate, :only=>[:show]
  before_filter :resource, :only=>[:update, :show, :destroy, :edit]
  authorize_resource

  has_scope :tagged_with, :as => :tag
  has_scope :accessible_by, :type=>:boolean, :default=>true do |c,s|
    s.accessible_by(c.current_ability)
  end

  def resource
    page_id = params[:id]
    if page_id.is_numeric?
      @page ||= Page.find(page_id)
    else
      @page ||= Page.where(["lower(pages.title) = ?", page_id.downcase.gsub(/[_]/, ' ')]).first
    end
    @attachments ||= @page.attachments
    @page
  end

  def maybe_authenticate
    unless user_signed_in?
      authenticate_user! unless current_ability.can? :read, resource
    end
  end

  def show
    show! do |format|
      set_children
    end
  end

  def edit
    edit! do |format|
      set_children
      @attachment = Attachment.new(:page=>@page)
      @s3provider = S3Provider.new(:key=>"attachments/#{current_user.id}")
    end
  end

  def create
    create! { (@parent_page ? page_child_path(@parent_page, @page) : @page) }
  end

  def new
    new! do |format|
      set_children
    end
  end

  def update
    update! do |format|
      if params[:child_id]
        @parent_page = @page
        @page = Page.find(params[:child_id])
        @page.parent = @parent_page
        @page.save
      end
    end
  end

  def set_children
    if @parent_page
      @children = @parent_page.children
    else
      @children = @page.children
    end
  end
end

