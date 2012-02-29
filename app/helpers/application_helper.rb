# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def default_page_title
    case session[:locale]
    when :es
      return 'Aceite de oliva las 7 encinas, El alamillo'
    when :en
      'Olive oil Las 7 encinas, The Alamillo'
    when :fr
      "Huile d’olive las 7 encinas, El alamillo"
    end  
  end
  
  def default_page_description
    case session[:locale]
    when :es
      return 'Aceite de oliva las 7 encinas, El alamillo'
    when :en
      'Olive oil Las 7 encinas, The Alamillo'
    when :fr
      "Huile d’olive las 7 encinas, El alamillo"
    end  
  end
  
end
