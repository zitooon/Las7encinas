class Admin::RequestsController < Admin::AdminApplicationController

  around_filter :check_ajax_request, :except => [:index]

  def index
    @requests = Request.paginate(:all, :page => params[:page])
    if request.xhr?
      render :update do |p|
        p.replace_html 'requests', :partial => 'admin/requests/list'
      end
      return
    end
  end

  def show
    @request = Request.find(params[:id])
    render :update do |p|
      p.replace_html 'requests', :partial => 'show'
    end
  end
  
  def toggle_treated
    @request = Request.find(params[:id])
    @request.is_treated = !@request.is_treated
    @request.save
    render :update do |p|
      p.replace_html 'toggle_treated', :text => 'Saved !'
      # p.visual_effect :pulsate, 'toggle_treated'
      p.delay(2) do
        p.replace_html 'toggle_treated', :text => ''
      end            
    end
  end

  def destroy
    request = Request.find(params[:id])
    request.destroy
    flash[:notice] = 'Request deleted !'
    index
  end
end
