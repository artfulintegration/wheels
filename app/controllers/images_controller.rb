class ImagesController < InheritedResources::Base
  respond_to :html, :js, :xml
  belongs_to :gallery

  def index
    index! do |format|
      if params[:CKEditorFuncNum]
        format.html {render :action=>:index, :layout=>"image_dialog"}
      end
    end
  end

  def create
    create! {edit_gallery_path(@gallery, params.slice(:CKEditor, :CKEditorFuncNum, :langCode))}
  end

  def show
    show!  do |format|
      if params[:CKEditorFuncNum]
        format.html {render :layout=>"image_dialog"}
      end
    end
  end

  def collection
    @images ||= end_of_association_chain.
      paginate(:page => params[:page], :order => 'created_at DESC' )
  end
end

