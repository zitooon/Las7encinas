module MenuHelper

  def sub_menu_for_accommodation; [:blue_suite, :tennis_house, :main_house]; end

  def sub_menu_for_facilities; [:meeting_room, :garden, :gym_spa, :games_room]; end

  def sub_menu_for(link)
    sub_menus = send("sub_menu_for_#{link}") rescue nil
    if sub_menus
      haml_tag :ul, :id => "#{link}_menu_sub", :class => 'sub_menu' do
        sub_menus.each do |sub_link|
          haml_tag :li, :class => "#{sub_link} #{params[:action].eql?(sub_link.to_s) ? ' sub_current' : ''}" do
            haml_concat link_to('<em>'+t(sub_link)+'</em>', send("#{sub_link}_#{link}_path"), :class => 'sub_vertical_menu')
          end    
        end
      end
    end
  end

  def menu
    haml_tag :ul, :class => 'sf-menu sf-vertical' do
      [:introduction, :estate, :surroundings, :accommodation, :gastronomy, :facilities, :activities, :services, :surrounding_area].each do |link|
        logger.debug link.to_s+' '+params[:action].eql?(link.to_s).to_s
        haml_tag :li, :id => "#{link}_menu", :class => "#{link} big #{(params[:action].eql?(link.to_s) or (send("sub_menu_for_#{link}").include?(params[:action].to_sym) rescue false)) ? ' current' : ''}" do
          haml_concat link_to('<em>'+t(link)+'</em>', send("#{link}_path"), :class => 'vertical_menu')
          sub_menu_for(link)
        end
      end
    end
    haml_concat javascript_tag("$('ul.sf-menu').superfish();")
  end

  def footer_menu
    haml_tag :ul do
      [:gallery, :contact].each do |link|
        haml_tag :li, :class => "#{link} #{params[:action].eql?(link.to_s) ? ' current' : ''}" do
          haml_concat link_to('<em>'+t(link)+'</em>', send("#{link}_path"), :class => 'horizontal_menu', :id => "#{link}_link")
        end
      end
    end
    haml_concat javascript_tag("$('#gallery_link').fancybox({'overlayColor'	: '#212C23'});")  
  end
  
end