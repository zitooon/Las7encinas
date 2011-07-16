class Admin::PictureCategoriesController < Admin::AdminApplicationController

  around_filter :check_ajax_request

  private
  
  def check_errors_and_pulsate(action_to_render)
    errors = @picture_category.errors.dup
    flash[:error] = 'Missing information'+(errors.size > 1 ? 's.' : '.')
    @picture_category.errors.clear
    render :update do |p|
      p.replace_html 'picture_categories', :partial => action_to_render
      p << "$('#picture_category_symbol').addClass('missing')" if errors[:symbol]
      p << "$('#picture_category_name_en').addClass('missing')" if errors[:name_en]
      p << "$('#picture_category_name_es').addClass('missing')" if errors[:name_es]
      p << "$('#picture_category_name_fr').addClass('missing')" if errors[:name_fr]
    end
  end
  
  public

  def index
    @picture_categories = PictureCategory.ordered.find(:all)
    @pictures = Picture.ordered.paginate(:all, :page => params[:page]) if @update_pictures
    render :update do |p|
      p.replace_html 'picture_categories', :partial => 'admin/picture_categories/list'
      if @update_pictures
        p.replace_html 'pictures', :partial => 'admin/pictures/list'
        p << Picture.set_lightbox
      end
    end
  end

  def new
    @picture_category = PictureCategory.new
    render :update do |p|
      p.replace_html 'picture_categories', :partial => 'new'
    end
  end

  def edit
    @picture_category = PictureCategory.find(params[:id])
    render :update do |p|
      p.replace_html 'picture_categories', :partial => 'edit'
    end
  end

  def create
    @picture_category = PictureCategory.create params[:picture_category]
    if @picture_category.errors.empty?
      flash[:notice] = 'Album created !'
      index
    else
      check_errors_and_pulsate('new')
    end
  end

  def update
    @picture_category = PictureCategory.find(params[:id])
    @picture_category.update_attributes(params[:picture_category])
    if @picture_category.errors.empty?
      flash[:notice] = 'Album updated !'
      @update_pictures = true
      index
    else
      check_errors_and_pulsate('edit')
    end
  end

  def destroy
    picture_category = PictureCategory.find(params[:id])
    Picture.destroy_all(:picture_category_id => picture_category.id)
    flash[:picture_notice] = "Pictures of album #{picture_category.name_en} deleted !"
    picture_category.destroy
    flash[:notice] = 'Album deleted !'
    @update_pictures = true
    index
  end
end