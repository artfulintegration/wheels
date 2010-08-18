class AttachmentsController < InheritedResources::Base
  respond_to :html, :js
  belongs_to :product_revision
  before_filter :authenticate_user!
  ajax_loading

  def index
    @attachment = new_attachment
    index!
  end

  def new
    @attachment = new_attachment
    new!
  end

  def create
    @attachment = new_attachment
    @attachment.attributes = params[:attachment].except("data")
    create!
  end

  def new_attachment
    Attachment.new :resource_class_name=>"ProductRevision",
      :resource_id=>params[:product_revision_id]
  end
end

