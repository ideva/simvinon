class KategoriTindakanMedisController < ApplicationController
  before_filter :login_required, :except => []
  # GET /kategori_tindakan_medis
  # GET /kategori_tindakan_medis.xml
  def index
    param_page = params[:page] rescue 1
    per_page = PAGINATION

    param = params[:param].to_s rescue ''
    tipe = params[:tipe]

    #@kategori_tindakan_medis = KategoriTindakanMedi.all.paginate :per_page => per_page, :page => param_page

    if params[:tipe]
      if tipe == "kode"
        field = "kode LIKE ?"
      elsif tipe == "nama"
        field = "nama LIKE ?"
      else
      end
      @kategori_tindakan_medis = KategoriTindakanMedi.where("#{field} ", "%"+param+"%").paginate :per_page => per_page, :page => param_page
    else
      @kategori_tindakan_medis = KategoriTindakanMedi.all.paginate :per_page => per_page, :page => param_page
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml =>  @kategori_tindakan_medis }
      format.js
    end
  end

  # GET /kategori_tindakan_medis/1
  # GET /kategori_tindakan_medis/1.xml
  def show
    @kategori_tindakan_medi = KategoriTindakanMedi.find(params[:id])
    pagination(params[:id], "show")

    @is_show = true
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @kategori_tindakan_medi }
    end
  end

  # GET /kategori_tindakan_medis/new
  # GET /kategori_tindakan_medis/new.xml
  def new
    @kategori_tindakan_medi = KategoriTindakanMedi.new

    respond_to do |format|
      flash[:extra_notice] = NEW_MSG
      format.html # new.html.erb
      format.xml  { render :xml => @kategori_tindakan_medi }
    end
  end

  # GET /kategori_tindakan_medis/1/edit
  def edit
    @id = params[:id]
    @kategori_tindakan_medi = KategoriTindakanMedi.find(params[:id])

    if @kategori_tindakan_medi.nil?
      redirect_to request.fullpath
      return
    end

    pagination(params[:id], "manage")
        begin
      user_being_acces, status = check_user_concurrence(@kategori_tindakan_medi)
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

  # POST /kategori_tindakan_medis
  # POST /kategori_tindakan_medis.xml
  def create
    @kategori_tindakan_medi = KategoriTindakanMedi.new(params[:kategori_tindakan_medi])
    respond_to do |format|
      if @kategori_tindakan_medi.save
        format.html { redirect_to(:action => "new", :notice => CREATE_MSG) }
        format.xml  { render :xml => @kategori_tindakan_medi, :status => :created, :location => @kategori_tindakan_medi }
      else
        @cancel_url = request.fullpath+"/new"
        format.html { render :action => "new" }
        format.xml  { render :xml => @kategori_tindakan_medi.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /kategori_tindakan_medis/1
  # PUT /kategori_tindakan_medis/1.xml
  def update
    @kategori_tindakan_medi = KategoriTindakanMedi.find(params[:id])
    user_being_acces, status = check_user_concurrence(@kategori_tindakan_medi)
    unless status
      user_concurrence_blocked(user_being_acces, false)
      return
    end
    @id = params[:id]
    respond_to do |format|
      if @kategori_tindakan_medi.update_attributes(params[:kategori_tindakan_medi])
        format.html { redirect_to(:action => "edit", :id => @id, :notice => UPDATE_MSG) }
        format.xml  { head :ok }
      else
        @cancel_url = request.fullpath+"/edit"
        format.html { render :action => "edit" }
        format.xml  { render :xml => @kategori_tindakan_medi.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /kategori_tindakan_medis/1
  # DELETE /kategori_tindakan_medis/1.xml
  def destroy
    @kategori_tindakan_medi = KategoriTindakanMedi.find(params[:id])
    @kategori_tindakan_medi.destroy
    @id = params[:id]

    respond_to do |format|
      if request.xhr?
          format.js do
            render :update do |page|
              page["list#{params[:id]}"].fade()
            end
          end
      else
        if @kategori_tindakan_medi.destroy
          format.html { redirect_to(:action => :searching_form, :id => "manage", :notice => DELETE_MSG) }
        else
          format.html { redirect_to(:action => "edit", :id => @id, :error => DELETE_CASCADE_ERROR_MSG) }
        end

        #format.xml  { head :ok }
      end
    end
  end
end
