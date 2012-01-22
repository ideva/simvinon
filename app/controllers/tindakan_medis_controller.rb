class TindakanMedisController < ApplicationController
  before_filter :login_required, :except => []
  # GET /tindakan_medis
  # GET /tindakan_medis.xml
  def index
    param_page = params[:page] rescue 1
    per_page = PAGINATION

    param = params[:param].to_s rescue ''
    tipe = params[:tipe]

    #@tindakan_medis = TindakanMedi.all.paginate :per_page => per_page, :page => param_page

    if params[:tipe]
      if tipe == "kode"
        field = "tindakan_medis.kode LIKE ?"
      elsif tipe == "kategori_tindakan_medis"
        field = "kategori_tindakan_medis.nama LIKE ?"
      elsif tipe == "nama"
        field = "tindakan_medis.nama LIKE ?"
      else
      end
      @tindakan_medis = TindakanMedi.joins("INNER JOIN kategori_tindakan_medis ON tindakan_medis.kode_kategori_tindakan_medis = kategori_tindakan_medis.kode").where("#{field} ", "%"+param+"%").paginate :per_page => per_page, :page => param_page
    else
      @tindakan_medis = TindakanMedi.joins("INNER JOIN kategori_tindakan_medis ON tindakan_medis.kode_kategori_tindakan_medis = kategori_tindakan_medis.kode").paginate :per_page => per_page, :page => param_page
    end


    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml =>  @tindakan_penunjangs }
      format.js
    end
  end

  # GET /tindakan_medis/1
  # GET /tindakan_medis/1.xml
  def show
    @tindakan_medi = TindakanMedi.find(params[:id])
    pagination(params[:id], "show")

    @is_show = true
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tindakan_medi }
    end
  end

  # GET /tindakan_medis/new
  # GET /tindakan_medis/new.xml
  def new
    @tindakan_medi = TindakanMedi.new
    @tindakan_medi.tarif = nil

    respond_to do |format|
      flash[:extra_notice] = NEW_MSG
      format.html # new.html.erb
      format.xml  { render :xml => @tindakan_medi }
    end
  end

  # GET /tindakan_medis/1/edit
  def edit
    @id = params[:id]
    @tindakan_medi = TindakanMedi.find(params[:id])

    if @tindakan_medi.nil?
      redirect_to request.fullpath
      return
    end

    pagination(params[:id], "manage")
    begin
      user_being_acces, status = check_user_concurrence(@tindakan_medi)
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

  # POST /tindakan_medis
  # POST /tindakan_medis.xml
  def create
    @tindakan_medi = TindakanMedi.new(params[:tindakan_medi])

    respond_to do |format|
      if @tindakan_medi.save
        format.html  { redirect_to(:action => "new", :notice => CREATE_MSG) }
        format.xml  { render :xml => @tindakan_medi, :status => :created, :location => @tindakan_medi }
      else
        @cancel_url = request.fullpath+"/new"
        format.html { render :action => "new" }
        format.xml  { render :xml => @tindakan_medi.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tindakan_medis/1
  # PUT /tindakan_medis/1.xml
  def update
    @tindakan_medi = TindakanMedi.find(params[:id])
    user_being_acces, status = check_user_concurrence(@tindakan_medi)
    unless status
      user_concurrence_blocked(user_being_acces, false)
      return
    end
    @id = params[:id]

    respond_to do |format|
      if @tindakan_medi.update_attributes(params[:tindakan_medi])
        format.html { redirect_to(:action => "edit", :id => @id, :notice => UPDATE_MSG) }
        format.xml  { head :ok }
      else
        @cancel_url = request.fullpath+"/edit"
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tindakan_medi.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tindakan_medis/1
  # DELETE /tindakan_medis/1.xml
  def destroy
    @tindakan_medi = TindakanMedi.find(params[:id])
    #@tindakan_medi.destroy
    @id = params[:id]

    respond_to do |format|
      if request.xhr?
          format.js do
            render :update do |page|
              page["list#{params[:id]}"].fade()
            end
          end
      else
        if @tindakan_medi.destroy
          format.html { redirect_to(:action => tindakan_medis_url, :id => "manage", :notice => DELETE_MSG) }
        else
          format.html { redirect_to(:action => "edit", :id => @id, :error => DELETE_CASCADE_ERROR_MSG) }
        end

        #format.xml  { head :ok }
      end
    end
  end
end
