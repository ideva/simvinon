class ObatsController < ApplicationController
  before_filter :login_required, :except => []
  # GET /obats
  # GET /obats.xml
  def index
    param_page = params[:page] rescue 1
    per_page = PAGINATION

    param = params[:param].to_s rescue ''
    tipe = params[:tipe]

    #@obats = Obat.all.paginate :per_page => per_page, :page => param_page

    if params[:tipe]
      if tipe == "kode"
        field = "obats.kode LIKE ?"
      elsif tipe == "nama"
        field = "obats.nama LIKE ?"
      else
        field = "kategori_obats.nama LIKE ?"
      end
     @obats = Obat.joins("INNER JOIN kategori_obats ON kategori_obats.kode = obats.kode_kategori").where("#{field} ", "%"+param+"%").paginate :per_page => per_page, :page => param_page
    else
      @obats = Obat.all.paginate :per_page => per_page, :page => param_page
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @obats }
      format.js
    end
  end

  # GET /obats/1
  # GET /obats/1.xml
  def show
    @obat = Obat.find(params[:id])
    pagination(params[:id], "show")
    session[:url_back] = "/#{self.controller_name}/index/new"
   
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @obat }
    end
  end

  # GET /obats/new
  # GET /obats/new.xml
  def new
    @obat = Obat.new

    @obat.jumlah = nil
    @obat.het_pack = nil
    @obat.het_satuan = nil
    respond_to do |format|
      flash[:extra_notice] = NEW_MSG
      format.html # new.html.erb
      format.xml  { render :xml => @obat }
    end
  end

  # GET /obats/1/edit
  def edit
    @id = params[:id]
    @obat = Obat.find(params[:id])
   
    if @obat.nil?
      redirect_to request.fullpath
      return
    end

    pagination(params[:id], "manage")

    begin
      user_being_acces, status = check_user_concurrence(@obat)
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

  # POST /obats
  # POST /obats.xml
  def create
    @obat = Obat.new(params[:obat])

    respond_to do |format|
      if @obat.save
        format.html { redirect_to(:action => "new", :notice => CREATE_MSG) }
        format.xml  { render :xml => @obat, :status => :created, :location => @obat }
      else
        @cancel_url = request.fullpath+"/new"
        format.html { render :action => "new" }
        format.xml  { render :xml => @obat.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /obats/1
  # PUT /obats/1.xml
  def update
    @obat = Obat.find(params[:id])

    user_being_acces, status = check_user_concurrence(@obat)
    unless status
      user_concurrence_blocked(user_being_acces, false)
      return
    end
    @id = params[:id]

    respond_to do |format|
      if @obat.update_attributes(params[:obat])
        format.html { redirect_to(:action => "edit", :id => @id, :notice => UPDATE_MSG) }
        format.xml  { head :ok }
      else
        @cancel_url = request.fullpath+"/edit"
        format.html { render :action => "edit" }
        format.xml  { render :xml => @obat.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /obats/1
  # DELETE /obats/1.xml
  def destroy
    @obat = Obat.find(params[:id])

    @id = params[:id]


    respond_to do |format|
      if request.xhr?
          format.js do
            render :update do |page|
              page["list#{params[:id]}"].fade()
            end
          end
      else
        if @obat.destroy
          format.html { redirect_to(obats_url,:notice => DELETE_MSG) }
        else
          format.html { redirect_to(:action => "edit", :id => @id, :error => DELETE_CASCADE_ERROR_MSG) }
        end

        #format.xml  { head :ok }
      end
      #format.html { redirect_to(obats_url) }
      #format.xml  { head :ok }
    end
  end
end
