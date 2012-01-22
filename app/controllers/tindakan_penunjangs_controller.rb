class TindakanPenunjangsController < ApplicationController
  before_filter :login_required, :except => []
  # GET /tindakan_penunjangs
  # GET /tindakan_penunjangs.xml
  def index
    param_page = params[:page] rescue 1
    per_page = PAGINATION

    param = params[:param].to_s rescue ''
    tipe = params[:tipe]

    #@tindakan_penunjangs = TindakanPenunjang.all.paginate :per_page => per_page, :page => param_page

    if params[:tipe]
      if tipe == "kode"
        field = "tindakan_penunjangs.kode LIKE ?"
      elsif tipe == "kategori_tindakan_penunjang"
        field = "kategori_tindakan_penunjangs.nama LIKE ?"
      elsif tipe == "nama"
        field = "tindakan_penunjangs.nama LIKE ?"
      else
      end
      @tindakan_penunjangs = TindakanPenunjang.joins("INNER JOIN kategori_tindakan_penunjangs ON tindakan_penunjangs.kode_kategori_tindakan_penunjang = kategori_tindakan_penunjangs.kode").where("#{field} ", "%"+param+"%").paginate :per_page => per_page, :page => param_page
    else
      @tindakan_penunjangs = TindakanPenunjang.joins("INNER JOIN kategori_tindakan_penunjangs ON tindakan_penunjangs.kode_kategori_tindakan_penunjang = kategori_tindakan_penunjangs.kode").paginate :per_page => per_page, :page => param_page
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml =>  @tindakan_penunjangs }
      format.js
    end
  end

  # GET /tindakan_penunjangs/1
  # GET /tindakan_penunjangs/1.xml
  def show
    @tindakan_penunjang = TindakanPenunjang.find(params[:id])
    pagination(params[:id], "show")

    @is_show = true
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tindakan_penunjang }
    end
  end

  # GET /tindakan_penunjangs/new
  # GET /tindakan_penunjangs/new.xml
  def new
    @tindakan_penunjang = TindakanPenunjang.new
    @tindakan_penunjang.tarif = nil

    respond_to do |format|
      flash[:extra_notice] = NEW_MSG
      format.html # new.html.erb
      format.xml  { render :xml => @tindakan_penunjang }
    end
  end

  # GET /tindakan_penunjangs/1/edit
  def edit
    @id = params[:id]
    @tindakan_penunjang = TindakanPenunjang.find(params[:id])

    pagination(params[:id], "manage")
   begin
      user_being_acces, status = check_user_concurrence(@tindakan_penunjang)
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

  # POST /tindakan_penunjangs
  # POST /tindakan_penunjangs.xml
  def create
    @tindakan_penunjang = TindakanPenunjang.new(params[:tindakan_penunjang])

    respond_to do |format|
      if @tindakan_penunjang.save
        format.html  { redirect_to(:action => "new", :notice => CREATE_MSG) }
        format.xml  { render :xml => @tindakan_penunjang, :status => :created, :location => @tindakan_penunjang }
      else
        @cancel_url = request.fullpath+"/new"
        format.html { render :action => "new" }
        format.xml  { render :xml => @tindakan_penunjang.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tindakan_penunjangs/1
  # PUT /tindakan_penunjangs/1.xml
  def update
    @tindakan_penunjang = TindakanPenunjang.find(params[:id])
    user_being_acces, status = check_user_concurrence(@tindakan_penunjang)
    unless status
      user_concurrence_blocked(user_being_acces, false)
      return
    end
    @id = params[:id]

    respond_to do |format|
      if @tindakan_penunjang.update_attributes(params[:tindakan_penunjang])
        format.html { redirect_to(:action => "edit", :id => @id, :notice => UPDATE_MSG) }
        format.xml  { head :ok }
      else
        @cancel_url = request.fullpath+"/edit"
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tindakan_penunjang.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tindakan_penunjangs/1
  # DELETE /tindakan_penunjangs/1.xml
  def destroy
    @tindakan_penunjang = TindakanPenunjang.find(params[:id])
    #@tindakan_penunjang.destroy
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
          format.html { redirect_to(:action => tindakan_penunjangs_url, :id => "manage", :notice => DELETE_MSG) }
        else
          format.html { redirect_to(:action => "edit", :id => @id, :error => DELETE_CASCADE_ERROR_MSG) }
        end

        #format.xml  { head :ok }
      end
    end
  end
end
