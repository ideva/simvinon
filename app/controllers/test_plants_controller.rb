class TestPlantsController < ApplicationController
  # GET /test_plants
  # GET /test_plants.xml
  def index
    #@test_plants = TestPlant.all

    param_page = params[:page] rescue 1
    per_page = PAGINATION

    param = params[:param].to_s rescue ''
    tipe = params[:tipe]

    if params[:tipe]
      if tipe == "hasil"
        field = "hasil LIKE ?"
        if param == "true"
          param = "1"
        elsif param == "false"
          param = "0"
        end
      elsif tipe == "no_pelayanan"
      elsif tipe == "tgl_keluar"
        field = "tgl_keluar LIKE ?"
        param.to_date.strftime("%Y-%m-%d")
      else
      end
      @test_plants = TestPlant.where("#{field}", "%"+param+"%").order("created_at desc").paginate :per_page => per_page, :page => param_page
    else
      @test_plants = TestPlant.order("created_at desc").paginate :per_page => per_page, :page => param_page
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @test_plants }
      format.js {}
    end
  end

  # GET /test_plants/1
  # GET /test_plants/1.xml
  def show
    @test_plant = TestPlant.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @test_plant }
    end
  end

  # GET /test_plants/new
  # GET /test_plants/new.xml
  def new
    @test_plant = TestPlant.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @test_plant }
    end
  end

  # GET /test_plants/1/edit
  def edit
    @test_plant = TestPlant.find(params[:id])
  end

  # POST /test_plants
  # POST /test_plants.xml
  def create
    @test_plant = TestPlant.new(params[:test_plant])

    respond_to do |format|
      if @test_plant.save
        format.html { redirect_to(:action => :index, :notice => CREATE_MSG) }
        format.xml  { render :xml => @test_plant, :status => :created, :location => @test_plant }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @test_plant.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /test_plants/1
  # PUT /test_plants/1.xml
  def update
    @test_plant = TestPlant.find(params[:id])

    respond_to do |format|
      if @test_plant.update_attributes(params[:test_plant])
        format.html { redirect_to(:action => :index, :notice => UPDATE_MSG) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @test_plant.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /test_plants/1
  # DELETE /test_plants/1.xml
  def destroy
    @test_plant = TestPlant.find(params[:id])
    @test_plant.destroy

    respond_to do |format|
      format.html { redirect_to(test_plants_url) }
      format.xml  { head :ok }
    end
  end
end
