class RequestsController < ApplicationController
  
  before_filter :is_logged, :only => [:show]
  
  def index
    new
  end
  
  def new
    @request ||= Request.new
    render :action => 'new', :layout => 'login'
  end
  
  def create
    @request = Request.create params[:request]
    if @request.errors.empty?
      flash[:notice] = t(:request_sent)
      redirect_to login_path
    else
      flash[:error] = t(:invalid_request)
      render :action => 'new', :layout => 'login'
    end
  end
  
  def show
  end
  
end
