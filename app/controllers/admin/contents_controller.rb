class Admin::ContentsController < Admin::AdminApplicationController

  around_filter :check_ajax_request, :except => [:index]

  def index
    @contents = Content.paginate(:all, :page => params[:page])
    if request.xhr?
      render :update do |p|
        p.replace_html 'contents', :partial => 'admin/contents/list'
      end
      return
    end
  end

  def show
    @content = Content.find(params[:id])
    render :update do |p|
      p.replace_html 'contents', :partial => 'show'
    end
  end

  def new
    @content = Content.new
    render :update do |p|
      p.replace_html 'contents', :partial => 'new'
    end
  end

  def edit
    @content = Content.find(params[:id])
    render :update do |p|
      p.replace_html 'contents', :partial => 'edit'
    end
  end

  def create
    @content = Content.create params[:content]
    if @content.errors.empty?
      flash[:notice] = 'Content created!'
      index
    else
        flash[:error] = @content.errors[:symbol]
      @content.errors.clear
      render :update do |p|
        p.replace_html 'contents', :partial => 'new'
        p.visual_effect :pulsate, 'content_symbol'
      end
    end
  end

  def update
    @content = Content.find(params[:id])
    @content.update_attributes(params[:content])
    if @content.errors.empty?
      flash[:notice] = 'Content updated !'
      index
    else
      flash[:error] = @content.errors[:code]
      @content.errors.clear
      render :update do |p|
        p.replace_html 'contents', :partial => 'edit'
        p.visual_effect :pulsate, 'content_symbol'
      end
    end
  end

  def destroy
    content = Content.find(params[:id])
    content.destroy
    flash[:notice] = 'Content deleted !'
    index
  end
  
end