module SlideshowHelper

  def slideshow_header(opt = {})
    haml_tag :div, :id => 'hslideshow' do    
      Picture.from_category(:header).each do |picture| 
        haml_tag :div, :class => 'diapo' do
          haml_concat image_tag(picture.photo.url(:original), :size => "134x525")
        end
      end
      haml_concat javascript_tag("new fadeCycle($('#hslideshow'), 6000, 1500);")
      haml_tag :div, :class => 'clear'  
    end
    haml_tag :div, :class => 'clear'  
  end

  def slideshow(pictures, opt = {})
    haml_tag :div, :id => 'slideshow' do    
      pictures.each do |picture|
        haml_tag :div, :class => 'diapo' do
          haml_concat link_to image_tag(picture.photo.url(:medium), :size => "300x360"), "/images/#{picture.photo.url(:large)}", :rel => "lightbox[all]", :title => picture.send("comment_#{session[:locale]}")
          haml_tag :div, :class => 'comment' do
            haml_concat picture.send("comment_#{session[:locale]}")
          end
        end
      end
      haml_concat javascript_tag("new fadeCycle($('#slideshow'), 4000, 1500);")
      haml_tag :div, :class => 'clear'  
    end
    haml_tag :div, :class => 'clear'  
  end

end
