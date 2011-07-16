class ContentsController < ApplicationController

  %w(introduction activities gastronomy contact estate services surroundings surrounding_area \
  accommodation blue_suite tennis_house main_house meeting_room garden gym_spa games_room).each do |r|
    r = r.to_sym
    define_method(r) do
      @content = Content.for_symbol(r).first
      @pictures = Picture.from_category(r)
      @pictures = Picture.random.only_in_gallery.all if @pictures.empty?
      render :action => "show"
    end
  end

end