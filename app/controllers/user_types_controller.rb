class UserTypesController < ApplicationController
  before_filter :login_required, :except => []
  @@global_path_information = "Administrator > Otorisasi > User Type"
  # GET /user_types
  # GET /user_types.xml
  def index
    @user_types = UserType.all

    respond_to do |format|
      @page_header = "#{@@global_path_information} > Lihat & Edit"
      flash[:extra_notice] = SHOW_MSG
      
      format.html # index.html.erb
      format.xml  { render :xml => @user_types }
    end
  end

  # GET /user_types/1
  # GET /user_types/1.xml
  def show
    @user_type = UserType.find(params[:id])

    respond_to do |format|
      @page_header = "#{@@global_path_information} > Lihat"
      flash[:extra_notice] = SHOW_MSG
      
      format.html # show.html.erb
      format.xml  { render :xml => @user_type }
    end
  end

  # GET /user_types/new
  # GET /user_types/new.xml
  def new
    @user_type = UserType.new

    respond_to do |format|
      @form_header = "Buat Baru"
      @page_header = "#{@@global_path_information} > #{ @form_header}"
      flash[:extra_notice] = NEW_MSG

      format.html # new.html.erb
      format.xml  { render :xml => @user_type }
    end
  end

  # GET /user_types/1/edit
  def edit
    @user_type = UserType.find(params[:id])
    @id = params[:id]
    @show_bt_page = false
    user_being_acces, status = check_user_concurrence(@user_type)
    if status
        #pagination(params[:id], "manage") # Global Function
        session[:url_back] = "/#{self.controller_name}"
        
        @form_header = "Perubahan Data"
        @page_header = "#{@@global_path_information} > #{@form_header}"
        flash[:extra_notice] = EDIT_MSG
    else
        # user_concurrence_blocked(user_being_acces, is_redirect)
        # true => redirect, false => render
        user_concurrence_blocked(user_being_acces, false)
    end

  end

  # POST /user_types
  # POST /user_types.xml
  def create
    @user_type = UserType.new(params[:user_type])
    function_list = params[:function_list]

    respond_to do |format|
      if @user_type.save
        function_list.each do |idfunction|
          object = UserTypeFunction.new(:iduser_type => @user_type.id, :idfunction => idfunction)
          object.save
        end
        format.html { redirect_to(:action => :new, :id => @user_type.id, :notice => CREATE_MSG) }
        format.xml  { render :xml => @user_type, :status => :created, :location => @user_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /user_types/1
  # PUT /user_types/1.xml
  def update
    @user_type = UserType.find(params[:id])

    respond_to do |format|
      if @user_type.update_attributes(params[:user_type])

        # -- ADJUST --
        data_in_db = UserTypeFunction.where(:iduser_type => @user_type.id)
        data_from_view = params[:function_list]
        unless data_from_view.nil? || data_from_view == ""
          array_data_from_view = data_from_view

          i = 0
          if data_in_db.length >= array_data_from_view.length # User deleted few tag
            data_in_db.each do |tag|
              if array_data_from_view[i].nil?
                old_tag = data_in_db[i]
                old_tag.destroy
              else
                # -- ADJUST --
                data_in_db[i].idfunction = array_data_from_view[i]
                data_in_db[i].save
              end
              i = i+1
            end
          else
            array_data_from_view.each do |tag|
              if data_in_db[i].nil?
                # -- ADJUST --
                new_data = UserTypeFunction.new(:iduser_type => @user_type.id, :idfunction => array_data_from_view[i])
                new_data.save
              else
                # -- ADJUST --
                data_in_db[i].idfunction = array_data_from_view[i]
                data_in_db[i].save
              end
              i = i+1
            end
          end
        else
        end
      
        format.html { redirect_to(:action => :edit, :id => @user_type.id, :notice => UPDATE_MSG) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /user_types/1
  # DELETE /user_types/1.xml
  def destroy
    @user_type = UserType.find(params[:id])
    @user_type.destroy

    respond_to do |format|
      format.html { redirect_to(user_types_url) }
      format.xml  { head :ok }
    end
  end
end
