class MappingDataPemeriksaansController < ApplicationController
  before_filter :login_required, :except => []
  # GET /mapping_data_pemeriksaans
  # GET /mapping_data_pemeriksaans.xml
  def index
    param_page = params[:page] rescue 1
    per_page = PAGINATION

    param = params[:param].to_s rescue ''
    tipe = params[:tipe]

   # @mapping_data_pemeriksaans = MappingDataPemeriksaan.all.paginate :per_page => per_page, :page => param_page

    if params[:tipe]
      if tipe == "kode_tm_rs"
        field = "kode_tm_rs LIKE ?"
      elsif tipe == "kode_tm_ejkbm"
        field = "kode_tm_ejkbm LIKE ?"
      else
      end
      @mapping_data_pemeriksaans = MappingDataPemeriksaan.where("#{field} ", "%"+param+"%").paginate :per_page => per_page, :page => param_page
    else
      @mapping_data_pemeriksaans = MappingDataPemeriksaan.all.paginate :per_page => per_page, :page => param_page
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @mapping_data_pemeriksaans }
      format.js
    end
  end

  # GET /mapping_data_pemeriksaans/1
  # GET /mapping_data_pemeriksaans/1.xml
  def show
    @mapping_data_pemeriksaan = MappingDataPemeriksaan.find(params[:id])
    pagination(params[:id], "show")

    

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @mapping_data_pemeriksaan }
    end
  end

  # GET /mapping_data_pemeriksaans/new
  # GET /mapping_data_pemeriksaans/new.xml
  def new
    @mapping_data_pemeriksaan = MappingDataPemeriksaan.new

    respond_to do |format|
      flash[:extra_notice] = NEW_MSG
      format.html # new.html.erb
      format.xml  { render :xml => @mapping_data_pemeriksaan }
    end
  end

  # GET /mapping_data_pemeriksaans/1/edit
  def edit
    @id = params[:id]
    @mapping_data_pemeriksaan = MappingDataPemeriksaan.find(params[:id])

    if @mapping_data_pemeriksaan.nil?
      redirect_to request.fullpath
      return
    end

    pagination(params[:id], "manage")

    begin
      user_being_acces, status = check_user_concurrence(@mapping_data_pemeriksaan)
      if status

        flash[:extra_notice] = EDIT_MSG
      else
        # user_concurrence_blocked(user_being_acces, is_redirect)
        # true => redirect, false => render
        user_concurrence_blocked(user_being_acces, false)
      end
    rescue
      respond_to do |format|
        error = "Data sedang digunakan, cobalah beberapa saat lagi"
        format.html {redirect_to "/main/resctricted?error=#{CGI::escape(error)}" }
      end
    end
  end

  # POST /mapping_data_pemeriksaans
  # POST /mapping_data_pemeriksaans.xml
  def create
    @mapping_data_pemeriksaan = MappingDataPemeriksaan.new(params[:mapping_data_pemeriksaan])

    respond_to do |format|
      if @mapping_data_pemeriksaan.save
        format.html { redirect_to(:action => "new", :notice => CREATE_MSG) }
        format.xml  { render :xml => @mapping_data_pemeriksaan, :status => :created, :location => @mapping_data_pemeriksaan }
      else
        @cancel_url = request.fullpath+"/new"
        format.html { render :action => "new" }
        format.xml  { render :xml => @mapping_data_pemeriksaan.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /mapping_data_pemeriksaans/1
  # PUT /mapping_data_pemeriksaans/1.xml
  def update
    @mapping_data_pemeriksaan = MappingDataPemeriksaan.find(params[:id])
     user_being_acces, status = check_user_concurrence(@mapping_data_pemeriksaan)
    unless status
      user_concurrence_blocked(user_being_acces, false)
      return
    end
    @id = params[:id]

    respond_to do |format|
      if @mapping_data_pemeriksaan.update_attributes(params[:mapping_data_pemeriksaan])
        format.html { redirect_to(:action => "edit", :id => @id, :notice => UPDATE_MSG) }
        format.xml  { head :ok }
      else
        @cancel_url = request.fullpath+"/edit"
        format.html { render :action => "edit" }
        format.xml  { render :xml => @mapping_data_pemeriksaan.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /mapping_data_pemeriksaans/1
  # DELETE /mapping_data_pemeriksaans/1.xml
  def destroy
    @mapping_data_pemeriksaan = MappingDataPemeriksaan.find(params[:id])

    @id = params[:id]

    respond_to do |format|
      if request.xhr?
          format.js do
            render :update do |page|
              page["list#{params[:id]}"].fade()
            end
          end
      else
        if @mapping_data_pemeriksaan.destroy
          format.html { redirect_to(mapping_data_pemeriksaans_url) }
        else
          format.html { redirect_to(:action => "edit", :id => @id, :error => DELETE_CASCADE_ERROR_MSG) }
        end

        #format.xml  { head :ok }
      end
    end
  end
end
