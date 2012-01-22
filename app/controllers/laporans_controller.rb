class LaporansController < ApplicationController
  # GET /laporans
  # GET /laporans.xml
  def index
    @laporans = Laporan.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @laporans }
    end
  end

  # GET /laporans/1
  # GET /laporans/1.xml
  def show
    @laporan = Laporan.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @laporan }
    end
  end

  # GET /laporans/new
  # GET /laporans/new.xml
  def new
    @laporan = Laporan.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @laporan }
    end
  end

  # GET /laporans/1/edit
  def edit
    @laporan = Laporan.find(params[:id])
  end

  # POST /laporans
  # POST /laporans.xml
  def create
    @laporan = Laporan.new(params[:laporan])

    respond_to do |format|
      if @laporan.save
        format.html { redirect_to(@laporan, :notice => 'Laporan was successfully created.') }
        format.xml  { render :xml => @laporan, :status => :created, :location => @laporan }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @laporan.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /laporans/1
  # PUT /laporans/1.xml
  def update
    @laporan = Laporan.find(params[:id])

    respond_to do |format|
      if @laporan.update_attributes(params[:laporan])
        format.html { redirect_to(@laporan, :notice => 'Laporan was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @laporan.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /laporans/1
  # DELETE /laporans/1.xml

  def destroy
    @laporan = Laporan.find(params[:id])
    @laporan.destroy

    respond_to do |format|
      format.html { redirect_to(laporans_url) }
      format.xml  { head :ok }
    end
  end

  def jenis_laporan(jenis = nil,rentang_awal = nil,rentang_akhir = nil, kode_kabupaten='')
    if jenis
      if jenis == 'laporan1'

       @nama_laporan = 'Rekapitulasi Klaim Biaya Total Pelayanan'
       @laporans = JenisPelayanan.find_by_sql("select jenis_pelayanans.nama AS 'Pelayanan',
          count(verifikasis.kode) AS 'Jumlah Pasien',
          SUM(verifikasis.lama_dirawat) AS 'Lama Rawat',
          SUM(verifikasis.total_tarif) AS 'Total Tarif'
          FROM jenis_pelayanans
          INNER JOIN(verifikasis)
          ON (jenis_pelayanans.kode = verifikasis.kode_jenis_pelayanan)
          where (verifikasis.created_at BETWEEN DATE('#{rentang_awal}') AND DATE('#{rentang_akhir}')
            AND kode_kabupaten LIKE '%#{kode_kabupaten}')
          GROUP BY jenis_pelayanans.nama
          ORDER BY jenis_pelayanans.kode")
      elsif jenis == 'laporan2'
        @nama_laporan = 'Rekapitulasi Klaim Biaya RITL'
        @laporans = Verifikasi.where('kode_jenis_pelayanan = 5 AND (created_at BETWEEN DATE( ? ) AND DATE( ? ))
                                      AND kode_kabupaten LIKE ?', rentang_awal, rentang_akhir, "%#{kode_kabupaten}").group('kode').order('created_at ASC')
      elsif jenis == 'laporan3'
        @nama_laporan = 'Rekapitulasi Klaim Biaya One Day Care'
        @laporans = Verifikasi.where('kode_jenis_pelayanan = 2 AND (created_at BETWEEN DATE( ? ) AND DATE( ? ))
                                      AND kode_kabupaten LIKE ?', rentang_awal, rentang_akhir, "%#{kode_kabupaten}").group('created_at')

      elsif jenis == 'laporan4'
        @nama_laporan = 'Rekapitulasi Klaim Biaya RJTL'
        @laporans = Verifikasi.where('kode_jenis_pelayanan = 4 AND (created_at BETWEEN DATE( ? ) AND DATE( ? ))
                                      AND kode_kabupaten LIKE ?', rentang_awal, rentang_akhir, "%#{kode_kabupaten}").group('created_at')

      elsif jenis == 'laporan5'
        @nama_laporan = 'Rekapitulasi Klaim Biaya IGD'
           @laporans = Verifikasi.where('kode_jenis_pelayanan = 1 AND (created_at BETWEEN DATE( ? ) AND DATE( ? ))
                                        AND kode_kabupaten LIKE ?', rentang_awal, rentang_akhir, "%#{kode_kabupaten}").group('created_at')

      else
      end

      if @laporans.empty?
      else
        @show_bt_print = true
        @link_to_print = "/#{self.controller_name}/print/#{jenis}?awal=#{rentang_awal}&akhir=#{rentang_akhir}&kode_kabupaten=#{kode_kabupaten}"
        @popup_width = 1000
        @popup_height = 500
      end
    end
  end

  def laporan
    
    #@show_bt_back = true
    @show_bt_ok = true
    @form_print = false
    @show_bt_print = false

    param_page = params[:page] rescue 1
    per_page = PAGINATION

    if request.post?
      # --- Adjust this ---
      bulan = params[:tanggal][:month].to_s rescue ""
      tahun = params[:tanggal][:year].to_s rescue ""
      jenis = params[:laporan][:jenis_laporan]
      @kode_kabupaten = params[:laporan][:kode_kabupaten].to_s rescue ''
      rentang_awal = tahun+"/"+bulan+"/1"
      rentang_akhir = tahun+"/"+bulan+"/31"
      
      
      jenis_laporan(jenis,rentang_awal,rentang_akhir, @kode_kabupaten)
      #@tanggal_awal = params[:laporan][:tanggal_awal]
      #@tanggal_akhir = params[:laporan][:tanggal_akhir]
      @jenis_laporan = params[:laporan][:jenis_laporan]
      # --- Adjust this ---
    else
      @laporans = Verifikasi.all.paginate :per_page => per_page, :page => param_page
    end
    

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @laporans }
      format.js
    end
  end

  def print
    @form_print = true
    @is_show = true
    respond_to do |format|
      @form_header = "Laporan"
      #@page_header = "#{@@global_path_information} > #{@form_header}"
      jenis = params[:id]
      rentang_awal = params[:awal]
      rentang_akhir = params[:akhir]
      kode_kabupaten = params[:kode_kabupaten]

      @jenis_laporan = jenis
      @awal = rentang_awal
      @akhir = rentang_akhir
      @nama_kabupaten = Kabupaten.find_by_kode(kode_kabupaten).nama rescue 'Semua Kabupaten'
      jenis_laporan(jenis,rentang_awal,rentang_akhir, kode_kabupaten)
      format.html { render :layout => "laporan" }
      format.xml  { render :xml => @laporan }
    end
  end
end
