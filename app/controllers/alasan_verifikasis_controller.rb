class AlasanVerifikasisController < ApplicationController
  before_filter :login_required, :except => []
  # GET /alasan_verifikasis
  # GET /alasan_verifikasis.xml
  def index
    param_page = params[:page] rescue 1
    per_page = PAGINATION

    param = params[:param].to_s rescue ''
    tipe = params[:tipe]
    
    #@alasan_verifikasis = AlasanVerifikasi.all.paginate :per_page => per_page, :page => param_page
    if params[:tipe]
      if tipe == "kode"
        field = "kode LIKE ?"
      elsif tipe == "alasan"
        field = "alasan LIKE ?"
      else
      end
      @alasan_verifikasis = AlasanVerifikasi.where("#{field} ", "%"+param+"%").paginate :per_page => per_page, :page => param_page
    else
      @alasan_verifikasis = AlasanVerifikasi.all.paginate :per_page => per_page, :page => param_page
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @alasan_verifikasis }
      format.js
    end
  end

  # GET /alasan_verifikasis/1
  # GET /alasan_verifikasis/1.xml
  def show
    @alasan_verifikasi = AlasanVerifikasi.find(params[:id])
    pagination(params[:id], "show")

    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @alasan_verifikasi }
    end
  end

  # GET /alasan_verifikasis/new
  # GET /alasan_verifikasis/new.xml
  def new
    @alasan_verifikasi = AlasanVerifikasi.new

    respond_to do |format|
      flash[:extra_notice] = NEW_MSG
      format.html # new.html.erb
      format.xml  { render :xml => @alasan_verifikasi }
    end
  end

  # GET /alasan_verifikasis/1/edit
  def edit
    @id = params[:id]
    @alasan_verifikasi = AlasanVerifikasi.find(params[:id])


    pagination(params[:id], "manage")

    begin
      user_being_acces, status = check_user_concurrence(@alasan_verifikasi)
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

  # POST /alasan_verifikasis
  # POST /alasan_verifikasis.xml
  def create
    @alasan_verifikasi = AlasanVerifikasi.new(params[:alasan_verifikasi])

    respond_to do |format|
      if @alasan_verifikasi.save
        format.html { redirect_to(:action => "new", :notice => CREATE_MSG) }
        format.xml  { render :xml => @alasan_verifikasi, :status => :created, :location => @alasan_verifikasi }
      else
        @cancel_url = request.fullpath+"/new"
        format.html { render :action => "new" }
        format.xml  { render :xml => @alasan_verifikasi.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /alasan_verifikasis/1
  # PUT /alasan_verifikasis/1.xml
  def update
    @alasan_verifikasi = AlasanVerifikasi.find(params[:id])

    user_being_acces, status = check_user_concurrence(@alasan_verifikasi)
    unless status
      user_concurrence_blocked(user_being_acces, false)
      return
    end
    @id = params[:id]

    respond_to do |format|
      if @alasan_verifikasi.update_attributes(params[:alasan_verifikasi])
        format.html { redirect_to(:action => "edit", :id => @id, :notice => UPDATE_MSG) }
        format.xml  { head :ok }
      else
        @cancel_url = request.fullpath+"/edit"
        format.html { render :action => "edit" }
        format.xml  { render :xml => @alasan_verifikasi.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /alasan_verifikasis/1
  # DELETE /alasan_verifikasis/1.xml
  def destroy
    @alasan_verifikasi = AlasanVerifikasi.find(params[:id])

    @id = params[:id]

    respond_to do |format|
     if request.xhr?
          format.js do
            render :update do |page|
              page["list#{params[:id]}"].fade()
            end
          end
      else
        if @alasan_verifikasi.destroy
          format.html { redirect_to(alasan_verifikasis_url) }
        else
          format.html { redirect_to(:action => "edit", :id => @id, :error => DELETE_CASCADE_ERROR_MSG) }
        end

        #format.xml  { head :ok }
      end
    end
  end
end
