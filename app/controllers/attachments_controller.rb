class AttachmentsController < InheritedResources::Base
  respond_to :html, :js
  belongs_to :page
  before_filter :authenticate_user!
  ajax_loading

  def index
    index! do |format|
      @attachment = @page.attachments.build
    end
  end
  def create
    create! {collection_url}
  end
end

