class JenisPelayanansController < ApplicationController
  # GET /jenis_pelayanans
  # GET /jenis_pelayanans.xml
  def index
    @jenis_pelayanans = JenisPelayanan.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @jenis_pelayanans }
    end
  end

  # GET /jenis_pelayanans/1
  # GET /jenis_pelayanans/1.xml
  def show
    @jenis_pelayanan = JenisPelayanan.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @jenis_pelayanan }
    end
  end

  # GET /jenis_pelayanans/new
  # GET /jenis_pelayanans/new.xml
  def new
    @jenis_pelayanan = JenisPelayanan.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @jenis_pelayanan }
    end
  end

  # GET /jenis_pelayanans/1/edit
  def edit
    @jenis_pelayanan = JenisPelayanan.find(params[:id])
  end

  # POST /jenis_pelayanans
  # POST /jenis_pelayanans.xml
  def create
    @jenis_pelayanan = JenisPelayanan.new(params[:jenis_pelayanan])

    respond_to do |format|
      if @jenis_pelayanan.save
        format.html { redirect_to(@jenis_pelayanan, :notice => 'Jenis pelayanan was successfully created.') }
        format.xml  { render :xml => @jenis_pelayanan, :status => :created, :location => @jenis_pelayanan }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @jenis_pelayanan.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /jenis_pelayanans/1
  # PUT /jenis_pelayanans/1.xml
  def update
    @jenis_pelayanan = JenisPelayanan.find(params[:id])

    respond_to do |format|
      if @jenis_pelayanan.update_attributes(params[:jenis_pelayanan])
        format.html { redirect_to(@jenis_pelayanan, :notice => 'Jenis pelayanan was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @jenis_pelayanan.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /jenis_pelayanans/1
  # DELETE /jenis_pelayanans/1.xml
  def destroy
    @jenis_pelayanan = JenisPelayanan.find(params[:id])
    @jenis_pelayanan.destroy

    respond_to do |format|
      format.html { redirect_to(jenis_pelayanans_url) }
      format.xml  { head :ok }
    end
  end
end
