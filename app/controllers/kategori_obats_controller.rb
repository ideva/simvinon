class KategoriObatsController < ApplicationController
  before_filter :login_required, :except => []
  # GET /kategori_obats
  # GET /kategori_obats.xml
  def index
    param_page = params[:page] rescue 1
    per_page = PAGINATION

    param = params[:param].to_s rescue ''
    tipe = params[:tipe]

   # @kategori_obats = KategoriObat.all.paginate :per_page => per_page, :page => param_page
    if params[:tipe]
      if tipe == "kode"
        field = "kode LIKE ?"
      #elsif tipe == "kategori_tindakan_penunjang"
      elsif tipe == "nama"
        field = "nama LIKE ?"
      else
      end
      @kategori_obats = KategoriObat.where("#{field} ", "%"+param+"%").paginate :per_page => per_page, :page => param_page
    else
      @kategori_obats = KategoriObat.all.paginate :per_page => per_page, :page => param_page
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @kategori_obats }
      format.js
    end
  end

  # GET /kategori_obats/1
  # GET /kategori_obats/1.xml
  def show
    @kategori_obat = KategoriObat.find(params[:id])
    pagination(params[:id], "show")

    
    respond_to do |format|
     
      format.html # show.html.erb
      format.xml  { render :xml => @kategori_obat }
    end
  end

  # GET /kategori_obats/new
  # GET /kategori_obats/new.xml
  def new
    @kategori_obat = KategoriObat.new

    respond_to do |format|
      flash[:extra_notice] = NEW_MSG
      format.html # new.html.erb
      format.xml  { render :xml => @kategori_obat }
    end
  end

  # GET /kategori_obats/1/edit
  def edit
    @id = params[:id]
    @kategori_obat = KategoriObat.find(params[:id])

    pagination(params[:id], "manage")

    begin
      user_being_acces, status = check_user_concurrence(@kategori_obat)
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

  

  # POST /kategori_obats
  # POST /kategori_obats.xml
  def create
    @kategori_obat = KategoriObat.new(params[:kategori_obat])

    respond_to do |format|
      if @kategori_obat.save
        format.html { redirect_to(:action => "new", :notice => CREATE_MSG) }
        format.xml  { render :xml => @kategori_obat, :status => :created, :location => @kategori_obat }
      else
        @cancel_url = request.fullpath+"/new"
          
        format.html { render :action => "new" }
        format.xml  { render :xml => @kategori_obat.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /kategori_obats/1
  # PUT /kategori_obats/1.xml
  def update
    @kategori_obat = KategoriObat.find(params[:id])
    user_being_acces, status = check_user_concurrence(@kategori_obat)
    unless status
      user_concurrence_blocked(user_being_acces, false)
      return
    end
    @id = params[:id]
    
    respond_to do |format|
      if @kategori_obat.update_attributes(params[:kategori_obat])
        format.html { redirect_to(:action => "edit", :id => @id, :notice => UPDATE_MSG) }
        format.xml  { head :ok }
      else
        @cancel_url = request.fullpath+"/edit"
        format.html { render :action => "edit" }
        format.xml  { render :xml => @kategori_obat.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /kategori_obats/1
  # DELETE /kategori_obats/1.xml
  def destroy
    @kategori_obat = KategoriObat.find(params[:id])
   
    @id = params[:id]

    respond_to do |format|
      if request.xhr?
          format.js do
            render :update do |page|
              page["list#{params[:id]}"].fade()
            end
          end
      else
        if @kategori_obat.destroy
          format.html { redirect_to(kategori_obats_url) }
        else
          format.html { redirect_to(:action => "edit", :id => @id, :error => DELETE_CASCADE_ERROR_MSG) }
        end

        #format.xml  { head :ok }
      end
    end
  end
end
