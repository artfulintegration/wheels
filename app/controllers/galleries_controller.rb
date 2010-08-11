class GalleriesController < InheritedResources::Base
  belongs_to :user, :optional=>true
  before_filter :load_user

  def index
    index! do |format|
      if params[:CKEditorFuncNum]
        format.html{
          render :action=>:index, :layout=>"image_dialog"
        }
      end
    end
  end

  def edit
    edit! do |format|
      if params[:CKEditorFuncNum]
        format.html{
          render :action=>:edit, :layout=>"image_dialog"
        }
      end
    end
  end

  def show
    show! do |format|
      @images = paginated_images_for(@gallery)
      if params[:CKEditorFuncNum]
        format.html{
          render :action=>:show, :layout=>"image_dialog"
        }
      end
    end
  end

  def new
    @gallery = Gallery.create(:user=>@user)
    new!
  end

  def create
    create! {images_path(params.slice(:CKEditor, :CKEditorFuncNum, :langCode))}
  end

  def load_user
    unless params[:user_id]
      @user ||= (current_user ? User.find(current_user.id) : super_user)
    end
  end
  helper_method :ckeditor_params, :paginated_images_for

  def paginated_images_for(gallery)
    @images ||= Image.where(:gallery_id=>gallery.id).paginate(:page => params[:page], :order => 'created_at DESC' )
  end

  def ckeditor_params
    params.slice(:CKEditor, :CKEditorFuncNum, :langCode)
  end
end

