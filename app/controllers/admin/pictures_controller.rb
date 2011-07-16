class Admin::PicturesController < Admin::AdminApplicationController

  around_filter :check_ajax_request, :except => [:index, :albums, :search, :create, :update]

  def index
    @pictures = Picture.ordered.paginate(:all, :page => params[:page])
    @picture_categories = PictureCategory.ordered.find(:all)
    if request.xhr?
      render :update do |p|
        p.replace_html 'pictures', :partial => 'admin/pictures/list'
        p.replace_html('picture_categories', :partial => 'admin/picture_categories/list')
        p << Picture.set_lightbox
      end
      return
    end
  end

  def albums
    @pictures = Picture.ordered.paginate(:all, :page => params[:page], :group => :picture_category_id)
    if request.xhr?
      render :update do |p|
        p.replace_html 'pictures', :partial => 'admin/pictures/list'
        p << Picture.set_lightbox
      end
    else
      @picture_categories = PictureCategory.ordered.find(:all)
      render :action => :index
    end
  end

  def search
    @category = PictureCategory.find(params[:s])
    @pictures = @category.pictures.paginate(:all, :page => params[:page])
    flash[:picture_notice] = "Pictures in album #{@category.name_en}"
   
      @picture_categories = PictureCategory.ordered.find(:all)
      render :action => :index
  end

  def show
    @picture = Picture.find params[:id]
    render :update do |p|
      p.replace_html 'pictures', :partial => 'show'
      p << Picture.set_lightbox
    end
  end

  def new
    @picture = Picture.new
    @picture_categories = PictureCategory.ordered.find(:all)
    if @picture_categories.empty?
      flash[:picture_error] = "You first need to create an album before uploading a new picture."
      index
    else
      render :update do |p|
        p.replace_html 'pictures', :partial => 'new'
      end
    end
  end

  def create
    @picture = Picture.create params[:picture]
    if @picture.errors.empty?
      flash[:picture_notice] = "Picture uploaded in album #{@picture.picture_category.name_en} !"
    else
      flash[:picture_error] = @picture.errors[:photo]
      @picture.errors.clear
    end
    pic_index = Picture.ordered.all.find_index{|x| x.id == @picture.id} rescue 1
    page_number = pic_index/Picture.per_page + 1
    redirect_to admin_pictures_path(:page => page_number)
  end

  def edit
    @picture = Picture.find params[:id]
    @picture_categories = PictureCategory.ordered.find(:all)
    render :update do |p|
      p.replace_html 'pictures', :partial => 'edit'
      p << Picture.set_lightbox
    end
  end

  def update
    @picture = Picture.find params[:id]
    @picture.update_attributes(params[:picture])
    flash[:picture_notice] = 'Picture updated !'
    pic_index = Picture.ordered.all.find_index{|x| x.id == @picture.id}
    page_number = pic_index/Picture.per_page + 1
    redirect_to admin_pictures_path(:page => page_number, :picture_id => @picture.id)
  end

  def destroy
    picture = Picture.find(params[:id])
    [:large, :medium, :thumb].each do |size|
      File.delete("/images/#{picture.photo.url(size)}") rescue nil
    end      
    picture.destroy
    flash[:picture_notice] = 'Picture deleted !'
    index
  end

end
