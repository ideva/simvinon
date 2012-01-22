class MappingPelayananLainsController < ApplicationController
  # GET /mapping_pelayanan_lains
  # GET /mapping_pelayanan_lains.xml
  def index
    @mapping_pelayanan_lains = MappingPelayananLain.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @mapping_pelayanan_lains }
    end
  end

  # GET /mapping_pelayanan_lains/1
  # GET /mapping_pelayanan_lains/1.xml
  def show
    @mapping_pelayanan_lain = MappingPelayananLain.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @mapping_pelayanan_lain }
    end
  end

  # GET /mapping_pelayanan_lains/new
  # GET /mapping_pelayanan_lains/new.xml
  def new
    @mapping_pelayanan_lain = MappingPelayananLain.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @mapping_pelayanan_lain }
    end
  end

  # GET /mapping_pelayanan_lains/1/edit
  def edit
    @mapping_pelayanan_lain = MappingPelayananLain.find(params[:id])
  end

  # POST /mapping_pelayanan_lains
  # POST /mapping_pelayanan_lains.xml
  def create
    @mapping_pelayanan_lain = MappingPelayananLain.new(params[:mapping_pelayanan_lain])

    respond_to do |format|
      if @mapping_pelayanan_lain.save
        format.html { redirect_to(@mapping_pelayanan_lain, :notice => 'Mapping pelayanan lain was successfully created.') }
        format.xml  { render :xml => @mapping_pelayanan_lain, :status => :created, :location => @mapping_pelayanan_lain }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @mapping_pelayanan_lain.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /mapping_pelayanan_lains/1
  # PUT /mapping_pelayanan_lains/1.xml
  def update
    @mapping_pelayanan_lain = MappingPelayananLain.find(params[:id])

    respond_to do |format|
      if @mapping_pelayanan_lain.update_attributes(params[:mapping_pelayanan_lain])
        format.html { redirect_to(@mapping_pelayanan_lain, :notice => 'Mapping pelayanan lain was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @mapping_pelayanan_lain.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /mapping_pelayanan_lains/1
  # DELETE /mapping_pelayanan_lains/1.xml
  def destroy
    @mapping_pelayanan_lain = MappingPelayananLain.find(params[:id])
    @mapping_pelayanan_lain.destroy

    respond_to do |format|
      format.html { redirect_to(mapping_pelayanan_lains_url) }
      format.xml  { head :ok }
    end
  end
end
