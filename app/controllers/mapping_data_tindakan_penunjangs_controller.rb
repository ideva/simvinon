class MappingDataTindakanPenunjangsController < ApplicationController
  before_filter :login_required, :except => []
  # GET /mapping_data_tindakan_penunjangs
  # GET /mapping_data_tindakan_penunjangs.xml
  def index
    param_page = params[:page] rescue 1
    per_page = PAGINATION

    param = params[:param].to_s rescue ''
    tipe = params[:tipe]

    #@mapping_data_tindakan_penunjangs = MappingDataTindakanPenunjang.all

    if params[:tipe]
      if tipe == "kode_rs"
        field = "kode_rs LIKE ?"
      elsif tipe == "kode_ejkbm"
        field = "kode_ejkbm LIKE ?"
      else
      end
      @mapping_data_tindakan_penunjangs = MappingDataTindakanPenunjang.where("#{field} ", "%"+param+"%").paginate :per_page => per_page, :page => param_page
    else
      @mapping_data_tindakan_penunjangs = MappingDataTindakanPenunjang.all.paginate :per_page => per_page, :page => param_page
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml =>  @mapping_data_tindakan_penunjangs }
      format.js
    end
  end

  # GET /mapping_data_tindakan_penunjangs/1
  # GET /mapping_data_tindakan_penunjangs/1.xml
  def show
    @mapping_data_tindakan_penunjang = MappingDataTindakanPenunjang.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @mapping_data_tindakan_penunjang }
    end
  end

  # GET /mapping_data_tindakan_penunjangs/new
  # GET /mapping_data_tindakan_penunjangs/new.xml
  def new
    @mapping_data_tindakan_penunjang = MappingDataTindakanPenunjang.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @mapping_data_tindakan_penunjang }
    end
  end

  # GET /mapping_data_tindakan_penunjangs/1/edit
  def edit
    #@mapping_data_tindakan_penunjang = MappingDataTindakanPenunjang.find(params[:id])
    @id = params[:id]
    @mapping_data_tindakan_penunjang = MappingDataTindakanPenunjang.find(params[:id])

    if @mapping_data_tindakan_penunjang.nil?
      redirect_to request.fullpath
      return
    end

    pagination(params[:id], "manage")

    begin
      user_being_acces, status = check_user_concurrence(@mapping_data_tindakan_penunjang)
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

  # POST /mapping_data_tindakan_penunjangs
  # POST /mapping_data_tindakan_penunjangs.xml
  def create
    @mapping_data_tindakan_penunjang = MappingDataTindakanPenunjang.new(params[:mapping_data_tindakan_penunjang])

    respond_to do |format|
      if @mapping_data_tindakan_penunjang.save
        format.html { redirect_to(:action => "index", :notice => CREATE_MSG) }
        format.xml  { render :xml => @mapping_data_tindakan_penunjang, :status => :created, :location => @mapping_data_tindakan_penunjang }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @mapping_data_tindakan_penunjang.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /mapping_data_tindakan_penunjangs/1
  # PUT /mapping_data_tindakan_penunjangs/1.xml
  def update
    @mapping_data_tindakan_penunjang = MappingDataTindakanPenunjang.find(params[:id])

    respond_to do |format|
      if @mapping_data_tindakan_penunjang.update_attributes(params[:mapping_data_tindakan_penunjang])
        format.html { redirect_to(:action => :edit, :id => params[:id], :notice => UPDATE_MSG) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @mapping_data_tindakan_penunjang.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /mapping_data_tindakan_penunjangs/1
  # DELETE /mapping_data_tindakan_penunjangs/1.xml
  def destroy
    @mapping_data_tindakan_penunjang = MappingDataTindakanPenunjang.find(params[:id])
    #@mapping_data_tindakan_penunjang.destroy

    @id = params[:id]

    respond_to do |format|
      if request.xhr?
          format.js do
            render :update do |page|
              page["list#{params[:id]}"].fade()
            end
          end
      else
        if @mapping_data_tindakan_penunjang.destroy
          format.html { redirect_to(mapping_data_tindakan_penunjangs_url) }
        else
          format.html { redirect_to(:action => "edit", :id => @id, :error => DELETE_CASCADE_ERROR_MSG) }
        end

        #format.xml  { head :ok }
      end
    end
  end
end
