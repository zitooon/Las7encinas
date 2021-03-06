module MenuHelper

  def menu
    haml_tag :ul, :class => 'sf-menu sf-vertical' do
      # :preparation => suppresion de cette page la
      [:on_the_table, :las_7_encinas, :olive_trees, :variety, :the_estate, :spain].each do |link|
        haml_tag :li, :id => "#{link}_menu", :class => "#{link} big #{(params[:action].eql?(link.to_s) or (send("sub_menu_for_#{link}").include?(params[:action].to_sym) rescue false)) ? ' current' : ''}" do
          haml_concat link_to('<em>'+t(link)+'</em>', "/#{session[:locale]}/#{link}", :class => 'vertical_menu')
        end
      end
    end
  end

  def footer_menu
    haml_tag :ul do
      [:gallery, :contact].each do |link|
        haml_tag :li, :class => "#{link} #{params[:action].eql?(link.to_s) ? ' current' : ''}" do
          haml_concat link_to('<em>'+t(link)+'</em>', link == :gallery ? send("#{link}_path") : "/#{session[:locale]}/#{link}", :class => 'horizontal_menu', :id => "#{link}_link")
        end
      end
    end
    haml_concat javascript_tag("$('#gallery_link').fancybox({'overlayColor'  : '#212C23'});")  
  end
    
end