class RuPusksController < ApplicationController
  # GET /ru_pusks
  # GET /ru_pusks.xml
  def index
    @ru_pusks = RuPusk.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ru_pusks }
    end
  end

  # GET /ru_pusks/1
  # GET /ru_pusks/1.xml
  def show
    @ru_pusk = RuPusk.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ru_pusk }
    end
  end

  # GET /ru_pusks/new
  # GET /ru_pusks/new.xml
  def new
    @ru_pusk = RuPusk.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ru_pusk }
    end
  end

  # GET /ru_pusks/1/edit
  def edit
    @ru_pusk = RuPusk.find(params[:id])
  end

  # POST /ru_pusks
  # POST /ru_pusks.xml
  def create
    @ru_pusk = RuPusk.new(params[:ru_pusk])

    respond_to do |format|
      if @ru_pusk.save
        format.html { redirect_to(@ru_pusk, :notice => 'Ru pusk was successfully created.') }
        format.xml  { render :xml => @ru_pusk, :status => :created, :location => @ru_pusk }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ru_pusk.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ru_pusks/1
  # PUT /ru_pusks/1.xml
  def update
    @ru_pusk = RuPusk.find(params[:id])

    respond_to do |format|
      if @ru_pusk.update_attributes(params[:ru_pusk])
        format.html { redirect_to(@ru_pusk, :notice => 'Ru pusk was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ru_pusk.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ru_pusks/1
  # DELETE /ru_pusks/1.xml
  def destroy
    @ru_pusk = RuPusk.find(params[:id])
    @ru_pusk.destroy

    respond_to do |format|
      format.html { redirect_to(ru_pusks_url) }
      format.xml  { head :ok }
    end
  end
end
