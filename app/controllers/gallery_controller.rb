class GalleryController < ApplicationController
  
  layout nil

  def show
    @pictures = Picture.only_in_gallery.ordered.find(:all, :group => :picture_category_id)        
  end

  def album
    @category = PictureCategory.find(params[:album])
    @pictures = @category.pictures.all
  end

end