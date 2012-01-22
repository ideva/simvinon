class UsersController < ApplicationController
  before_filter :login_required, :except => []

  def index
    per_page = PAGINATION

    if super_admin?
      @users= User.all.paginate :per_page => per_page, :page => params[:page]
    else
      @users= User.where("iduser_level != 1").paginate :per_page => per_page, :page => params[:page]
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @blogs }
    end

  end
  
  # render new.rhtml
  def new
    @user = User.new

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @user }
    end
  end

  def edit
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @user }
    end
  end

 
  def create    
    @user = User.new(params[:user])
    success = @user && @user.save
    if success && @user.errors.empty?
      
       redirect_to(:action => :new, :id => "new", :notice => CREATE_MSG)
       #redirect_back_or_default('/', :notice => "Thanks for signing up!  We're sending you an email with your activation code.")
    else
      flash.now[:error]  = "Data tidak lengkap"
      render :action => 'new'
    end
  end

  def form_change_password
    @show_bt_save = true
    @show_bt_cancel = true
    @show_bt_back = true
    session[:url_back] = "/#{self.controller_name}"
    @user = User.find(params[:id])
    @form_header = "Perubahan Password"
  end

  def update_password
    @user = User.find(params[:id])
    respond_to do |format|
      if User.authenticate(@user.login, params[:user][:old_password]).nil?
        flash[:error] = "Sandi Lama salah"
        format.html { render :action => "form_change_password" }
      else
        @user.password = params[:user][:password]
        @user.password_confirmation = params[:user][:password_confirmation]
        if @user.password == @user.password_confirmation && @user.save
          format.html { redirect_to(:action => "form_change_password", :id => @user.id, :notice => 'Sandi telah diganti') }
          format.xml  { head :ok }
        else
          flash[:error] = "Sandi Baru dan Konfirmasi Sandi Baru tidak sama"
          format.html { render :action => "form_change_password" }
          format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])

        format.html { redirect_to(:action => "edit", :id => @user.id, :notice => UPDATE_MSG) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @id = params[:id]

    respond_to do |format|
      if request.xhr?
          format.js do
            render :update do |page|
              page["list#{params[:id]}"].fade()
            end
          end
      else
        if @user.destroy
          format.html { redirect_to(users_url,:notice => DELETE_MSG) }
        else
          format.html { redirect_to(:action => "edit", :id => @id, :error => DELETE_CASCADE_ERROR_MSG) }
        end
      end
    end
  end

end
