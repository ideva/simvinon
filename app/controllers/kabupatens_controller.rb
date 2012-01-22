class KabupatensController < ApplicationController
  # GET /kabupatens
  # GET /kabupatens.xml
  def index
    @kabupatens = Kabupaten.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @kabupatens }
    end
  end

  # GET /kabupatens/1
  # GET /kabupatens/1.xml
  def show
    @kabupaten = Kabupaten.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @kabupaten }
    end
  end

  # GET /kabupatens/new
  # GET /kabupatens/new.xml
  def new
    @kabupaten = Kabupaten.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @kabupaten }
    end
  end

  # GET /kabupatens/1/edit
  def edit
    @kabupaten = Kabupaten.find(params[:id])
  end

  # POST /kabupatens
  # POST /kabupatens.xml
  def create
    @kabupaten = Kabupaten.new(params[:kabupaten])

    respond_to do |format|
      if @kabupaten.save
        format.html { redirect_to(@kabupaten, :notice => 'Kabupaten was successfully created.') }
        format.xml  { render :xml => @kabupaten, :status => :created, :location => @kabupaten }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @kabupaten.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /kabupatens/1
  # PUT /kabupatens/1.xml
  def update
    @kabupaten = Kabupaten.find(params[:id])

    respond_to do |format|
      if @kabupaten.update_attributes(params[:kabupaten])
        format.html { redirect_to(@kabupaten, :notice => 'Kabupaten was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @kabupaten.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /kabupatens/1
  # DELETE /kabupatens/1.xml
  def destroy
    @kabupaten = Kabupaten.find(params[:id])
    @kabupaten.destroy

    respond_to do |format|
      format.html { redirect_to(kabupatens_url) }
      format.xml  { head :ok }
    end
  end
end
