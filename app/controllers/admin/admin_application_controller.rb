require 'digest/sha1'

class Admin::AdminApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
 
  before_filter :authenticate
  
  def check_ajax_request
    if request.xhr?
      yield
    else
      redirect_to admin_root_path
    end
  end

  protected
  def authenticate
    # if Rails.env == "production"
    return redirect_to introduction_path if !session[:admin]
    
    authenticate_or_request_with_http_basic do |username, password|
      username_hash = Digest::SHA1.hexdigest(username)
      password_hash = Digest::SHA1.hexdigest(password)
      username_hash == "d033e22ae348aeb5660fc2140aec35850c4da997" && password_hash == "40c2fa24e8cfd2cf86276755686eb10ad9fce29d"
    end
    # end
  end
end
