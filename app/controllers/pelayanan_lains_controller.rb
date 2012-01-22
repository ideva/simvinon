class PelayananLainsController < ApplicationController
  # GET /pelayanan_lains
  # GET /pelayanan_lains.xml
  def index
    @pelayanan_lains = PelayananLain.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pelayanan_lains }
    end
  end

  # GET /pelayanan_lains/1
  # GET /pelayanan_lains/1.xml
  def show
    @pelayanan_lain = PelayananLain.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @pelayanan_lain }
    end
  end

  # GET /pelayanan_lains/new
  # GET /pelayanan_lains/new.xml
  def new
    @pelayanan_lain = PelayananLain.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @pelayanan_lain }
    end
  end

  # GET /pelayanan_lains/1/edit
  def edit
    @pelayanan_lain = PelayananLain.find(params[:id])
  end

  # POST /pelayanan_lains
  # POST /pelayanan_lains.xml
  def create
    @pelayanan_lain = PelayananLain.new(params[:pelayanan_lain])

    respond_to do |format|
      if @pelayanan_lain.save
        format.html { redirect_to(@pelayanan_lain, :notice => 'Pelayanan lain was successfully created.') }
        format.xml  { render :xml => @pelayanan_lain, :status => :created, :location => @pelayanan_lain }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @pelayanan_lain.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pelayanan_lains/1
  # PUT /pelayanan_lains/1.xml
  def update
    @pelayanan_lain = PelayananLain.find(params[:id])

    respond_to do |format|
      if @pelayanan_lain.update_attributes(params[:pelayanan_lain])
        format.html { redirect_to(@pelayanan_lain, :notice => 'Pelayanan lain was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @pelayanan_lain.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pelayanan_lains/1
  # DELETE /pelayanan_lains/1.xml
  def destroy
    @pelayanan_lain = PelayananLain.find(params[:id])
    @pelayanan_lain.destroy

    respond_to do |format|
      format.html { redirect_to(pelayanan_lains_url) }
      format.xml  { head :ok }
    end
  end
end
