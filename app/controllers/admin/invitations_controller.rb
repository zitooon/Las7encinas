class Admin::InvitationsController < Admin::AdminApplicationController

  around_filter :check_ajax_request, :except => [:index, :new]

  def index
    @invitations = Invitation.paginate(:all, :page => params[:page])
    if request.xhr?
      render :update do |p|
        p.replace_html 'invitations', :partial => 'admin/invitations/list'
      end
      return
    end
  end

  def show
    @invitation = Invitation.find(params[:id])
    render :update do |p|
      p.replace_html 'invitations', :partial => 'show'
    end
  end

  def new
    @invitation = Invitation.new
    @invitation.generate_code
    if params[:request_id]
      @invitation.comment = Request.find(params[:request_id]).compact_infos
      params.delete(:request_id)
    end
    if request.xhr?
      render :update do |p|
        p.replace_html 'invitations', :partial => 'new'
      end
      return
    end
  end

  def edit
    @invitation = Invitation.find(params[:id])
    render :update do |p|
      p.replace_html 'invitations', :partial => 'edit'
    end
  end

  def create
    @invitation = Invitation.create params[:invitation]
    if @invitation.errors.empty?
      flash[:notice] = 'Invitation created!'
      index
    else
      flash[:error] = @invitation.errors[:code]
      @invitation.errors.clear
      render :update do |p|
        p.replace_html 'invitations', :partial => 'new'
        p.visual_effect :pulsate, 'invitation_code'
      end
    end
  end

  def update
    @invitation = Invitation.find(params[:id])
    @invitation.update_attributes(params[:invitation])
    if @invitation.errors.empty?
      flash[:notice] = 'Invitation updated !'
      index
    else
      flash[:error] = @invitation.errors[:code]
      @invitation.errors.clear
      render :update do |p|
        p.replace_html 'invitations', :partial => 'edit'
        p.visual_effect :pulsate, 'invitation_code'
      end
    end
  end

  def destroy
    invitation = Invitation.find(params[:id])
    invitation.destroy
    flash[:notice] = 'Invitation deleted !'
    index
  end
end
