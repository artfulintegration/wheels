class SitemapsController < InheritedResources::Base
  ajax_loading
  respond_to :html, :js, :json
  before_filter :parse_request_url, :only=>:show
  before_filter :resource, :except=>[:new, :create, :index]
  before_filter :collection, :only=>[:index]
  before_filter :new_resource, :only=>[:new, :create]
  before_filter :authenticate_user!, :authorize_action!

  def index
    collection.reject!{|t| t==Sitemap.lost_and_found} if Sitemap.lost_and_found.children.empty?
    index! do |format|
      format.json{render :json=>collection.as_json}
    end
  end

  def parse_request_url
    if params[:level1]
      @sitemap = Sitemap.find_by_path(*[1,2,3,4].map{|t|params["level#{i}".to_sym]})
    end
  end

  def create
    @sitemap = new_resource
    @sitemap.resource = @sitemap.resource_type.constantize.new
    @sitemap.save
    respond_with @sitemap do |format|
      format.json {render :json=> json_obj.as_json}
    end
  end

  def json_obj
    {
      :status => @sitemap.errors.empty? ? 1 : 0,
      :errors => @sitemap.errors,
      :id     => @sitemap.id,
      :resource_type => @sitemap.resource_type,
      :resource_id   => @sitemap.resource_id,
      :menu_text     => @sitemap.menu_text,
    }
  end

  def show
    show! do |format|
      format.html{
        if resource.resource.is_a? ExternalLink
          redirect_to resource.resource.url
        elsif resource.resource.is_a? Page

        end
      }
      format.json{render :json=>resource.as_json}
      format.js{redirect_to(url_for(resource.resource)+'.js')}
    end
  end

  def destroy
    if (resource.parent == Sitemap.lost_and_found) || (resource.resource.is_a? AppConfig)
      resource.destroy
    else
      resource.parent = Sitemap.lost_and_found
      resource.save
    end
    respond_with resource
  end

  def update
    resource.parent = parent
    update! do |format|
      if params.stringify_keys["sitemap"]["position"]
        childrunz = Array.new(parent.children.sorted)
        childrunz.delete(resource)
        childrunz.insert(params.stringify_keys["sitemap"]["position"].to_i, resource)
        childrunz.each_with_index do |child, idx|
          child.position = idx
          child.save
        end
      end
      format.json {render :json=> json_obj.as_json}
    end
  end

  def sort
    params[:formula_herb_children].each_with_index do |id, index|
      FormulaHerb.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing => true
  end



  #helper methods

  def authorize_action!
    authorize! :manage, Sitemap
  end

  def resource
    @sitemap ||= Sitemap.find(params[:id]) if params[:id]
  end

  def collection
    @sitemaps ||= SitemapArray.new(parent.children)
  end

  def new_resource
    @sitemap ||= Sitemap.new(params[:sitemap])
  end

  def parent
    unless @parent
      if params[:parent_id]
        @parent = Sitemap.find(params[:parent_id])
      else
        if params[:action] == "index"
          @parent = Sitemap.root
        else
          @parent = resource.try(:parent)
        end
      end
    end
    @parent
  end

  private
  def resource_would_be_orphaned?
    resource.resource.sitemaps.size==1 &&
        resource.resource.sitemaps[0] == resource
  end

  def resource_is_in_lost_and_found?
    resource.parent==Sitemap.lost_and_found
  end
end

