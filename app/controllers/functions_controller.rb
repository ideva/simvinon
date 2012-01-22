class FunctionsController < ApplicationController
  before_filter :login_required, :except => []
  @@global_path_information = "Administrator > Function"
  # GET /functions
  # GET /functions.xml
  def index
    @functions = Function.find(:all, :order => "name")
    if current_user.super_admin
      @show_bt_delete = true
    end
    
    respond_to do |format|
      @page_header = "#{@@global_path_information} > Lihat & Edit"
      flash[:extra_notice] = SHOW_MSG
      
      format.html # index.html.erb
      format.xml  { render :xml => @functions }
    end
  end

  # GET /functions/1
  # GET /functions/1.xml
  def show
    @function = Function.find(params[:id])
    pagination(params[:id], "show") # Global Function
    
    respond_to do |format|
      @page_header = "#{@@global_path_information} > Lihat"
      format.html # show.html.erb
      format.xml  { render :xml => @function }
    end
  end

  # GET /functions/new
  # GET /functions/new.xml
  def new
    @function = Function.new

    @form_header = "Buat Baru"
    @page_header = "#{@@global_path_information} > #{@form_header}"
    flash[:extra_notice] = NEW_MSG
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @function }
    end
  end

  # GET /functions/1/edit
  def edit
    @function = Function.find(params[:id])

    user_being_acces, status = check_user_concurrence(@function)
    if status
        pagination(params[:id], "manage") # Global Function
        session[:url_back] = "/#{self.controller_path}"

        @form_header = "Perubahan Data Function"
        @page_header = "#{@@global_path_information} > #{@form_header}"
        flash[:extra_notice] = EDIT_MSG
    else
        # user_concurrence_blocked(user_being_acces, is_redirect)
        # true => redirect, false => render
        user_concurrence_blocked(user_being_acces, false)
    end
  end

  # POST /functions
  # POST /functions.xml
  def create
    @function = Function.new(params[:function])

    respond_to do |format|
      if @function.save
        format.html { redirect_to(:action => "new", :notice => CREATE_MSG) }
        #format.html { redirect_to(@function, :notice => 'Function was successfully created.') }
        format.xml  { render :xml => @function, :status => :created, :location => @function }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @function.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /functions/1
  # PUT /functions/1.xml
  def update
    @function = Function.find(params[:id])
    @id = params[:id]
    
    respond_to do |format|
      if @function.update_attributes(params[:function])
        format.html { redirect_to(:action => "edit", :id => @id, :notice => UPDATE_MSG) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @function.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /functions/1
  # DELETE /functions/1.xml
  def destroy
    @function = Function.find(params[:id])
    @function.destroy

    respond_to do |format|
      format.html { redirect_to(:action => "index", :notice => DELETE_MSG) }
      format.xml  { head :ok }
    end
  end

  def batch_destroy
    no_data = false

    if params[:check_box]
      check_boxs = params[:check_box]
      check_boxs.each do |id|
        @function = Function.find(id)
        @function.destroy
      end
    else
      no_data = true
    end

    if no_data
      notice = "Tidak ada data yang terhapus"
    else
      notice = DELETE_MSG
    end

    respond_to do |format|
      format.html { redirect_to(:action => "index", :notice => notice) }
      format.xml  { head :ok }
    end
  end

  def search_user_form
    @show_bt_search = true
    @user = User.new
    respond_to do |format|
      @page_header = "#{@@global_path_information} > Pencarian"
      flash[:extra_notice] = "Isikan kriteria pencarian anda kemudian tekan tombol temukan"
      format.html # new.html.erb
      format.xml  { render :xml => @function }
   end
  end

  def searching_user
    @show_bt_save = true
    @show_bt_back = true
    session[:url_back] = "/#{self.controller_name}/search_user_form/new"

    iduser = params[:user][:id]
    @user = User.find(iduser)
    @function = Function.new
    @functions = Function.all

    respond_to do |format|
      @page_header = "#{@@global_path_information} > Hak Akses"
      format.html # new.html.erb
      format.xml  { render :xml => @function }
    end
  end

  def assign_user_function_list
    iduser = params[:user][:id]
    functions = params[:function_list]

    @user = User.find(iduser)
    function_list = ''
    functions.each do |idfunction|
      unless idfunction == ""
        function_list = idfunction +','+function_list
      end
    end
    @user.function_list = function_list
    @user.save

    respond_to do |format|
      @show_bt_save = true
      @function = Function.new
      @functions = Function.all
       flash[:extra_notice] = "Inputkan data lalu tekan tombol Simpan untuk menyimpan"
       flash[:notice] = "Data telah disimpan"
       format.html { render :action => "searching_user" }
    end

  end

end
