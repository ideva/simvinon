class PemeriksaansController < ApplicationController
  before_filter :login_required, :except => []
  # GET /pemeriksaans
  # GET /pemeriksaans.xml
  def index
    param_page = params[:page] rescue 1
    per_page = PAGINATION

    param = params[:param].to_s rescue ''
    tipe = params[:tipe]

    #@pemeriksaans = Pemeriksaan.all.paginate :per_page => per_page, :page => param_page

    if params[:tipe]
      if tipe == "kode"
        field = "kode LIKE ?"
      elsif tipe == "nama"
        field = "nama LIKE ?"
      else
      end
      @pemeriksaans = Pemeriksaan.where("#{field} ", "%"+param+"%").paginate :per_page => per_page, :page => param_page
    else
      @pemeriksaans = Pemeriksaan.all.paginate :per_page => per_page, :page => param_page
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pemeriksaans }
      format.js
    end
  end

  # GET /pemeriksaans/1
  # GET /pemeriksaans/1.xml
  def show
    @pemeriksaan = Pemeriksaan.find(params[:id])
    pagination(params[:id], "show")

    session[:url_back] = "/#{self.controller_name}/index/new"
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @pemeriksaan }
    end
  end

  # GET /pemeriksaans/new
  # GET /pemeriksaans/new.xml
  def new
    @pemeriksaan = Pemeriksaan.new

    @pemeriksaan.tarif = nil
    respond_to do |format|
      flash[:extra_notice] = NEW_MSG
      format.html # new.html.erb
      format.xml  { render :xml => @pemeriksaan }
    end
  end

  # GET /pemeriksaans/1/edit
  def edit
    @id = params[:id]
    @pemeriksaan = Pemeriksaan.find(params[:id])

    if @pemeriksaan.nil?
      redirect_to request.fullpath
      return
    end

    pagination(params[:id], "manage")

    begin
      user_being_acces, status = check_user_concurrence(@pemeriksaan)
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

  # POST /pemeriksaans
  # POST /pemeriksaans.xml
  def create
    @pemeriksaan = Pemeriksaan.new(params[:pemeriksaan])

    respond_to do |format|
      if @pemeriksaan.save
        format.html { redirect_to(:action => "new", :notice => CREATE_MSG) }
        format.xml  { render :xml => @pemeriksaan, :status => :created, :location => @pemeriksaan }
      else
        @cancel_url = request.fullpath+"/new"
        format.html { render :action => "new" }
        format.xml  { render :xml => @pemeriksaan.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pemeriksaans/1
  # PUT /pemeriksaans/1.xml
  def update
    @pemeriksaan = Pemeriksaan.find(params[:id])

    user_being_acces, status = check_user_concurrence(@pemeriksaan)
    unless status
      user_concurrence_blocked(user_being_acces, false)
      return
    end
    @id = params[:id]

    respond_to do |format|
      if @pemeriksaan.update_attributes(params[:pemeriksaan])
        format.html { redirect_to(:action => "edit", :id => @id, :notice => UPDATE_MSG) }
        format.xml  { head :ok }
      else
        @cancel_url = request.fullpath+"/edit"
        format.html { render :action => "edit" }
        format.xml  { render :xml => @pemeriksaan.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pemeriksaans/1
  # DELETE /pemeriksaans/1.xml
  def destroy
    @pemeriksaan = Pemeriksaan.find(params[:id])
    @id = params[:id]

    respond_to do |format|
      if request.xhr?
          format.js do
            render :update do |page|
              page["list#{params[:id]}"].fade()
            end
          end
      else
        if @pemeriksaan.destroy
          format.html { redirect_to(pemeriksaans_url) }
        else
          format.html { redirect_to(:action => "edit", :id => @id, :error => DELETE_CASCADE_ERROR_MSG) }
        end

        #format.xml  { head :ok }
      end
     # format.html { redirect_to(pemeriksaans_url) }
     # format.xml  { head :ok }
    end
  end
end
