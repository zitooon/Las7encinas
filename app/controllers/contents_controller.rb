class ContentsController < ApplicationController

  %w(spain the_estate olive_trees variety preparation las_7_encinas on_the_table contact).each do |r|
    r = r.to_sym
    define_method(r) do
      @content = Content.for_symbol(r).first
      @pictures = Picture.from_category(r)
      @pictures = Picture.random.only_in_gallery.all if @pictures.empty?
      render :action => "show"
    end
  end
  
  def index
    redirect_to "/en/on_the_table", :status => 301
  end

end