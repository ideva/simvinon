class VerifikasisController < ApplicationController
  before_filter :login_required, :except => [:ws_vi_rs]
  protect_from_forgery :except => [:ws_vi_rs]
  #@@separator = "_"
  # GET /verifikasis
  # GET /verifikasis.xml
  def index
    @show_bt_add = false
    if params[:id] == "new"
      status_param = "status_verifikasi_verifikator = 0"
      @judul = "Data Verifikasi Baru"
    elsif params[:id] == "valid"
      status_param = "status_pengiriman = 2 && status_verifikasi_verifikator = 1 && sent_to_ejkbm = 1"
      @judul = "Data Sukses Terverifikasi"
    elsif params[:id] == "invalid"
      status_param = "status_pengiriman = 2 && status_verifikasi_verifikator = 2 && sent_to_ejkbm = 1"
      @judul = "Data Gagal Terverifikasi"
    elsif params[:id] == "pending"
      status_param = "status_pengiriman = 3"
      @judul = "Data Verifikasi Perbaikan"
      @url_back = "/#{self.controller_name}/index/#{params[:id]}"
    elsif params[:id] == "kirim_rs"
      status_param = "(status_pengiriman = 1 AND sent_to_rs = 0 )"
      @judul = "Data Verifikasi Siap Dikirim RS"
      @show_bt_upload_rs = true
    elsif params[:id] == "kirim"
      status_param = "( status_pengiriman = 1 )"
      #status_param = "(status_pengiriman == 1 AND status_verifikasi_verifikator != 0)"
      @judul = "Data Verifikasi Siap Dikirim"
      @show_bt_upload = true
    end
    
    param_page = params[:page] rescue 1
    per_page = PAGINATION
    
    param = params[:param].to_s rescue ''
    tipe = params[:tipe]

    if request.xhr?
      if tipe == "no_klaim"
        field = "no_klaim_rs LIKE '%#{param}%'"
      elsif tipe == "no_reg"
        field = "no_reg  LIKE '%#{param}%'"
      elsif tipe == "kode_kabupaten"
        field = "kode_kabupaten  LIKE '%#{param}%'"
      elsif tipe == "no_ejkbm"
        field = "no_ejkbm LIKE '%#{param}%'"
      elsif tipe == "nik"
        field = "nik LIKE '%#{param}%'"
      elsif tipe == "tgl_keluar"
        field = "tgl_keluar LIKE '%#{param}%'"
        param.to_date.strftime("%Y-%m-%d")
      elsif tipe == "status"
        field = "status_verifikasi_verifikator LIKE '%#{param}%'"
      elsif tipe == "sent_to_rs"
        field = "sent_to_rs LIKE '%#{param}%'"
      elsif tipe == "sent_to_ejkbm"
        field = "sent_to_ejkbm LIKE '%#{param}%'"
      else
        field = "id LIKE '%#{param}%'"
      end
      @verifikasis = Verifikasi.where("#{field} AND #{status_param}").paginate :per_page => per_page, :page => param_page
    else
      @verifikasis = Verifikasi.where("#{status_param}").paginate :per_page => per_page, :page => param_page
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @verifikasis }
      format.js {}
    end
  end

  # GET /verifikasis/1
  # GET /verifikasis/1.xml
  def show
    @verifikasi = Verifikasi.find(params[:id])

    @verifikasi_tindakan_medis = VerifikasiTindakan.where(:kode_verifikasi => @verifikasi.kode, :flag => 1)
    @verifikasi_tindakan_penunjangs = VerifikasiTindakan.where(:kode_verifikasi => @verifikasi.kode, :flag => 2)
    @verifikasi_pemeriksaans = VerifikasiPemeriksaan.where(:kode_verifikasi => @verifikasi.kode, :flag => 1)
    @verifikasi_obats = VerifikasiObat.where(:kode_verifikasi => @verifikasi.kode, :flag => 1)
    @verifikasi_pelayanan_lains = VerifikasiPelayananLain.where(:kode_verifikasi => @verifikasi.kode)

    @verifikasi_pemeriksaans_non_mapping = VerifikasiPemeriksaan.where(:kode_verifikasi => @verifikasi.kode, :flag => 2)
    @verifikasi_tindakan_medis_non_mapping = VerifikasiTindakan.where(:kode_verifikasi => @verifikasi.kode, :flag => 3)
    @verifikasi_obats_non_mapping = VerifikasiObat.where(:kode_verifikasi => @verifikasi.kode, :flag => 2)
    @verifikasi_pelayanan_lains_non_mapping = VerifikasiPelayananLain.where(:kode_verifikasi => @verifikasi.kode)
    
    session[:url_back] = set_url_back
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @verifikasi }
    end
  end

  # GET /verifikasis/new
  # GET /verifikasis/new.xml
  def new
    @verifikasi = Verifikasi.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @verifikasi }
    end
  end

  def set_url_back
#    if @verifikasi.status_verifikasi_verifikator == 0
#      url = "/#{self.controller_name}/index/new"
#    elsif @verifikasi.status_verifikasi_verifikator == 1 || @verifikasi.status_verifikasi_verifikator == 2
#      url = "/#{self.controller_name}/index/kirim"
#    elsif @verifikasi.status_verifikasi_verifikator == 3
#      url = "/#{self.controller_name}/index/pending"
#    end

    if @verifikasi.status_pengiriman == 0
      url = "/#{self.controller_name}/index/new"
    elsif @verifikasi.status_pengiriman == 1
      url = "/#{self.controller_name}/index/kirim"
    elsif @verifikasi.status_pengiriman == 3
      url = "/#{self.controller_name}/index/pending"
    end
    return url
  end

  # GET /verifikasis/1/edit
  def edit
    @id = params[:id]
    @verifikasi = Verifikasi.find(params[:id])
    @show_bt_ok = true
    @show_bt_save = false
    @save_message = "Apakah anda yakin untuk memproses data ini?"
    #pagination(params[:id], "manage")
    
    session[:url_back] = set_url_back
    
    begin
      user_being_acces, status = check_user_concurrence(@verifikasi)
      
      if status
        flash[:extra_notice] = EDIT_MSG
        @verifikasi_tindakan_medis = VerifikasiTindakan.where(:kode_verifikasi => @verifikasi.kode, :flag => 1)
        @verifikasi_tindakan_penunjangs = VerifikasiTindakan.where(:kode_verifikasi => @verifikasi.kode, :flag => 2)
        @verifikasi_pemeriksaans = VerifikasiPemeriksaan.where(:kode_verifikasi => @verifikasi.kode, :flag => 1)
        @verifikasi_obats = VerifikasiObat.where(:kode_verifikasi => @verifikasi.kode, :flag => 1)
        @verifikasi_pelayanan_lains = VerifikasiPelayananLain.where(:kode_verifikasi => @verifikasi.kode)

        @verifikasi_pemeriksaans_non_mapping = VerifikasiPemeriksaan.where(:kode_verifikasi => @verifikasi.kode, :flag => 2)
        @verifikasi_tindakan_medis_non_mapping = VerifikasiTindakan.where(:kode_verifikasi => @verifikasi.kode, :flag => 3)
        @verifikasi_obats_non_mapping = VerifikasiObat.where(:kode_verifikasi => @verifikasi.kode, :flag => 2)
        @verifikasi_pelayanan_lains_non_mapping = VerifikasiPelayananLain.where(:kode_verifikasi => @verifikasi.kode)
        @show_bt_delete = false
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
    
#    if @verifikasi.iduser.nil?
#    else
#      if @verifikasi.iduser != current_user.id
#        redirect_to "/main/resctricted/new"
#      end
#    end
   
  end

  # POST /verifikasis
  # POST /verifikasis.xml
  def create
    @verifikasi = Verifikasi.new(params[:verifikasi])

    respond_to do |format|
      if @verifikasi.save
        format.html { redirect_to(@verifikasi, :notice => 'Verifikasi was successfully created.') }
        format.xml  { render :xml => @verifikasi, :status => :created, :location => @verifikasi }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @verifikasi.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update_obat(kode_verifikasi)
    verifikasi_obats = VerifikasiObat.where(:kode_verifikasi => kode_verifikasi)
    verifikasi_obats.each do |object|
      object.attributes = params["verifikasi_obat#{object.kode}"]
      object.save
    end
  end

  def update_pemeriksaan(kode_verifikasi)
    objects = VerifikasiPemeriksaan.where(:kode_verifikasi => kode_verifikasi)
    objects.each do |object|
      object.attributes = params["verifikasi_pemeriksaan#{object.kode}"]
      object.save
    end
  end

  def update_tindakan(kode_verifikasi)
    objects = VerifikasiTindakan.where(:kode_verifikasi => kode_verifikasi)
    objects.each do |object|
      object.attributes = params["verifikasi_tindakan#{object.kode}"]
      object.save
    end
  end

  def update_pelayanan(kode_verifikasi)
    objects = VerifikasiPelayananLain.where(:kode_verifikasi => kode_verifikasi)
    objects.each do |object|
      object.attributes = params["verifikasi_pelayanan_lain#{object.kode}"]
      object.save
    end
  end

  # PUT /verifikasis/1
  # PUT /verifikasis/1.xml
  def update
    @verifikasi = Verifikasi.find(params[:id])
    url = set_url_back
    
    user_being_acces, status = check_user_concurrence(@verifikasi)
    unless status
      user_concurrence_blocked(user_being_acces, false)
      return
    end
    @id = params[:id]
    @verifikasi.status_pengiriman = 1 # data siap untuk dikirim

    respond_to do |format|
      if @verifikasi.update_attributes(params[:verifikasi])

        update_obat(@verifikasi.kode)
        update_pemeriksaan(@verifikasi.kode)
        update_tindakan(@verifikasi.kode)
        update_pelayanan(@verifikasi.kode)

        Verifikasi.set_status_verifikasi_global_verifikator(@verifikasi.kode)

        #Verifikasi.set_log(@verifikasi.kode)
        format.html { redirect_to(url, :notice => UPDATE_MSG) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @verifikasi.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /verifikasis/1
  # DELETE /verifikasis/1.xml
  def destroy
    @verifikasi = Verifikasi.find(params[:id])
    @verifikasi.destroy

    respond_to do |format|
      format.html { redirect_to(verifikasis_url) }
      format.xml  { head :ok }
    end
  end

  def ws_vi_rs
    status = ''
    
    no_skp_ejkbm = params[:no_transaksi_ejkbm] #params[:no_skp]
    no_ejkbm = params[:no_ejkbm]#params[:no_peserta]
    alamat = params[:alamat]
    nama_pasien = params[:nama_pasien]
    no_kk = params[:no_kk]
    nik = params[:nik]
    ktp = params[:no_ktp]
    norm = params[:norm]
    kode_kabupaten = params[:kode_kabupaten]
    kode_ru_pusk =  params[:kode_ru_pusk]

    no_reg = params[:no_reg]
    no_klaim_rs = params[:no_klaim]
    tgl_masuk = params[:tgl_masuk]
    tgl_keluar = params[:tgl_keluar]
    lama_dirawat = params[:lama_dirawat]
    nama_dokter = params[:nama_dokter]
    kode_instalasi_layanan = params[:kode_instalasi_layanan]
    nama_instalasi_layanan = params[:nama_instalasi_layanan]
    keluhan = params[:keluhan]
    diagnosa_icd = params[:diagnosa_icd]
    nama_diagnosa_icd = params[:nama_diagnosa_icd]
    kode_jenis_pelayanan = params[:jenis_pelayanan]# kode_jenis_pelayanan

#    no_daftar_rs = params[:no_daftar]
#    kode_kabupaten = params[:kode_kabupaten]

    verifikasi = Verifikasi.find_by_no_reg(no_reg)
    if verifikasi.nil?
      verifikasi = Verifikasi.new
    else
#      # mengirim data yang sudah dikirim ke EJKBM
#      if verifikasi.sent_to_ejkbm
#        @status = 2
#        respond_to do |format|
#          format.html { }
#          format.xml  { }
#        end
#        return
#      end
      
       # Menerima data yang telah Layak diverifikasi
       if verifikasi.status_verifikasi_verifikator == 1
        @status = 3
        respond_to do |format|
          format.html { }
          format.xml  { }
        end
        return
      end
    end

    begin
      Verifikasi.transaction do
        verifikasi.no_reg = no_reg
        verifikasi.no_klaim_rs = no_klaim_rs
        verifikasi.no_skp_ejkbm = no_skp_ejkbm
        verifikasi.nama_pasien = nama_pasien
        verifikasi.no_ejkbm = no_ejkbm
        verifikasi.kode_kabupaten = kode_kabupaten
        if (kode_ru_pusk.to_s == '' rescue true)
          verifikasi.kode_ru_pusk = Setting.find_by_name('RS_PUSK_KODE').string_value
        else
          verifikasi.kode_ru_pusk = kode_ru_pusk
        end
        verifikasi.norm = norm
        verifikasi.tgl_masuk = tgl_masuk
        verifikasi.tgl_keluar = tgl_keluar
        verifikasi.lama_dirawat = lama_dirawat
        verifikasi.no_kk = no_kk
        verifikasi.nik = nik
        verifikasi.ktp = ktp
        verifikasi.dokter = nama_dokter
        verifikasi.kode_instalasi_layanan = kode_instalasi_layanan
        verifikasi.nama_instalasi_layanan = nama_instalasi_layanan
        verifikasi.keluhan = keluhan
        verifikasi.diagnosa_icd = diagnosa_icd
        verifikasi.nama_diagnosa_icd = nama_diagnosa_icd
        verifikasi.kode_jenis_pelayanan  = kode_jenis_pelayanan
        verifikasi.sent_to_rs = false
        if verifikasi.status_verifikasi_verifikator.to_s == "2" || verifikasi.status_verifikasi_verifikator.to_s == "3"  # menerima data lama yang Tidak layak, maka ke perbaikan
          verifikasi.status_pengiriman = 3
        elsif verifikasi.status_verifikasi_verifikator.to_s == "1"
          verifikasi.status_pengiriman = 2
          verifikasi.sent_to_rs = true
        else
          verifikasi.status_pengiriman = 0
        end
        verifikasi.iduser = 3
        #verifikasi.alamat = alamat
        #verifikasi.no_daftar_rs = no_daftar_rs
        verifikasi.save
        kode_verifikasi = verifikasi.kode

        prosess_pemeriksaan(kode_verifikasi)
        prosess_obat(kode_verifikasi)
        prosess_tindakan(kode_verifikasi)
        prosess_pelayanan_lain(kode_verifikasi)

        verifikasi_obats = VerifikasiObat.where(:kode_verifikasi => kode_verifikasi)
        verifikasi_tindakans = VerifikasiTindakan.where(:kode_verifikasi => kode_verifikasi)
        verifikasi_pemeriksaans = VerifikasiPemeriksaan.where(:kode_verifikasi => kode_verifikasi)
        verifikasi_pelayanan_lains = VerifikasiPelayananLain.where(:kode_verifikasi => kode_verifikasi)
        verifikasi.total_tarif = verifikasi_obats.sum(:sub_total_tarif_ejkbm) + verifikasi_tindakans.sum(:sub_total_tarif_ejkbm) + verifikasi_pemeriksaans.sum(:sub_total_tarif_ejkbm) + verifikasi_pelayanan_lains.sum(:sub_total_tarif)
        verifikasi.counter = verifikasi.counter + 1
        verifikasi.save

        Verifikasi.set_status_verifikasi_global_sistem(verifikasi.kode)

        @verifikasi = verifikasi
        @verifikasi_tindakan_medis = verifikasi_tindakans
        @verifikasi_obats = verifikasi_obats
        @verifikasi_pemeriksaans = verifikasi_pemeriksaans
        @verifikasi_pelayanan_lains = verifikasi_pelayanan_lains
        @status = "1"
        status = @status        
      end
     rescue Exception => e
       @status = "0"
       status = e.to_s
     end

    verifikasi_log = VerifikasiRequestLog.new
    verifikasi_log.request_in = "\n--URL-------\n"+request.url.to_s+"\n--Parameter-------\n"+request.parameters.to_s+"\n--Result-------\n"+status
    verifikasi_log.save

    verifikasi_to_ejkbm_first = VerifikasiToEjkbmFirst.find_by_kode_verifikasi_and_sent_to_ejkbm(verifikasi.kode, false)
    if verifikasi_to_ejkbm_first.nil?
      Verifikasi.simpan_to_verifikasi_ejkbm_first(verifikasi)
    end

    respond_to do |format|
        format.html { }
        format.xml  { }
      end
  end

  def prosess_pemeriksaan(kode_verifikasi)

    tmp_jumlah_hari = params[:jumlah_hari].split("_") rescue Array.new
    tmp_no_transaksi = params[:no_transaksi_pemeriksaan].split("_") rescue Array.new  
    tmp_kode = params[:kode_pemeriksaan].split("_") rescue Array.new

    verifikasi_pemeriksaans = VerifikasiPemeriksaan.where(:kode_verifikasi => kode_verifikasi)
    if tmp_kode.length > verifikasi_pemeriksaans.length || tmp_kode.length < verifikasi_pemeriksaans.length
      verifikasi_pemeriksaans.destroy_all
    end

    i = 0
    tmp_kode.each do |kode|
      kode = kode.strip rescue ''
      no_transaksi = tmp_no_transaksi[i].strip rescue ''
     
      verifikasi_pemeriksaan = VerifikasiPemeriksaan.find_by_kode_verifikasi_and_no_transaksi(kode_verifikasi,no_transaksi)
      if verifikasi_pemeriksaan.nil?
        verifikasi_pemeriksaan = VerifikasiPemeriksaan.new
        verifikasi_pemeriksaan.kode_verifikasi = kode_verifikasi
      else
      end

      verifikasi_pemeriksaan.kode_pemeriksaan_rs = kode 
      verifikasi_pemeriksaan.jumlah = tmp_jumlah_hari[i].strip rescue ''
      verifikasi_pemeriksaan.no_transaksi = no_transaksi

      verifikasi_pemeriksaan.save
      i = i+1
    end
  end

  def prosess_obat(kode_verifikasi)
    tgl_obats = params[:tgl_obat] # split by _
    kode_obats = params[:kode_obat] # split by _
    nama_obats = params[:nama_obat] # split by _
    jumlah_obats = params[:jumlah_obat] # split by _
    no_transaksi = params[:no_transaksi_obat]

    tmp_no_transaksi = no_transaksi.split("_") rescue Array.new
    tmp_tgl_obat = tgl_obats.split("_") rescue Array.new
    tmp_kode = kode_obats.split("_") rescue Array.new
    tmp_nama = nama_obats.split("_") rescue Array.new
    tmp_jumlah = jumlah_obats.split("_") rescue Array.new
    #puts "===========#{kode_obat}====#{tmp_kode}===#{tmp_kode[1]}===================================="
    verifikasi_obats = VerifikasiObat.where(:kode_verifikasi => kode_verifikasi)
    if tmp_kode.length > verifikasi_obats.length || tmp_kode.length < verifikasi_obats.length
      verifikasi_obats.destroy_all
    end

    i = 0
    tmp_kode.each do |kode|
      #puts "===============#{i}==#{kode}==#{tmp_kode[1]}===================================="
      kode = kode.strip rescue ''
      jumlah = tmp_jumlah[i].strip rescue 0
      nama_obat = tmp_nama[i].strip rescue ''
      tgl_obat = tmp_tgl_obat[i].strip rescue ''
      no_transaksi = tmp_no_transaksi[i].strip rescue ''
      
      verifikasi_obat = VerifikasiObat.find_by_kode_verifikasi_and_no_transaksi(kode_verifikasi,no_transaksi)
      if verifikasi_obat.nil?
        verifikasi_obat = VerifikasiObat.new
        verifikasi_obat.kode_verifikasi = kode_verifikasi
      else
      end
      verifikasi_obat.kode_obat_rs = kode
      verifikasi_obat.nama_obat_rs = nama_obat
      verifikasi_obat.jumlah_obat_rs = jumlah
      verifikasi_obat.tgl_obat = tgl_obat
      verifikasi_obat.no_transaksi = no_transaksi

      verifikasi_obat.save
      i=i+1
    end
  end

  def prosess_tindakan(kode_verifikasi)
    tgl_t_medis = params[:tgl_tm] # split by _
    kode_t_medis = params[:kode_tm] # split by _
    nama_t_medis = params[:nama_tm] # split by _
    jumlah_t_medis = params[:jumlah_tm] # split by _
    #jenis_pelayanans = params[:jenis_pelayanan] # split by _
    
    tmp_tgl_t_medis = tgl_t_medis.split("_") rescue Array.new
    tmp_kode = kode_t_medis.split("_") rescue Array.new
    tmp_jumlah = jumlah_t_medis.split("_") rescue Array.new
    tmp_nama_t_medis = nama_t_medis.split("_") rescue Array.new
    #tmp_jenis_pelayanans = jenis_pelayanans.split("_")

    no_transaksi = params[:no_transaksi_tm]
    tmp_no_transaksi = no_transaksi.split("_") rescue Array.new

    verifikasi_tindakans = VerifikasiTindakan.where(:kode_verifikasi => kode_verifikasi)
    if tmp_kode.length > verifikasi_tindakans.length || tmp_kode.length < verifikasi_tindakans.length
      verifikasi_tindakans.destroy_all
    end

    i = 0
    tmp_kode.each do |kode|
      #puts "===============#{i}==#{kode}==#{tmp_kode[1]}===================================="
      tgl_t_medis_rs = tmp_tgl_t_medis[i].strip rescue ''
      kode = kode.strip rescue ''
      jumlah = tmp_jumlah[i].strip rescue 0
      nama_t_medi = tmp_nama_t_medis[i].strip rescue ''
      no_transaksi = tmp_no_transaksi[i].strip rescue ''
      #jenis_pelayanan = tmp_jenis_pelayanans[i].strip rescue 1

      verifikasi_tindakan = VerifikasiTindakan.find_by_kode_verifikasi_and_no_transaksi(kode_verifikasi,no_transaksi)
      if verifikasi_tindakan.nil?
        verifikasi_tindakan = VerifikasiTindakan.new
        verifikasi_tindakan.kode_verifikasi = kode_verifikasi
      else
      end

      verifikasi_tindakan.kode_t_medis_rs = kode
      verifikasi_tindakan.nama_t_medis_rs = nama_t_medi
      verifikasi_tindakan.jumlah_t_medis_rs = jumlah
      verifikasi_tindakan.tgl_t_medis_rs = tgl_t_medis_rs  
      verifikasi_tindakan.no_transaksi = no_transaksi

      verifikasi_tindakan.save
      i=i+1
    end
  end

  def prosess_pelayanan_lain(kode_verifikasi)
    tgl_pelayanan_lains = params[:tgl_pl] # split by _
    kode_pelayanan_lains = params[:kode_pl] # split by _
    nama_pelayanan_lains = params[:nama_pl] # split by _
    jumlah_pelayanan_lains = params[:jumlah_pl] # split by _
    harga_satuan_pelayanan_lains = params[:harga_satuan_pl] # split by _
    #jenis_pelayanans = params[:jenis_pelayanan] # split by _
    no_transaksi = params[:no_transaksi_pl]
    tmp_no_transaksi = no_transaksi.split("_") rescue Array.new

    tmp_tgl_pelayanan_lain = tgl_pelayanan_lains.split("_") rescue Array.new
    tmp_kode = kode_pelayanan_lains.split("_") rescue Array.new
    tmp_jumlah = jumlah_pelayanan_lains.split("_") rescue Array.new
    tmp_nama = nama_pelayanan_lains.split("_") rescue Array.new
    tmp_harga = harga_satuan_pelayanan_lains.split("_") rescue Array.new
    #tmp_jenis_pelayanans = jenis_pelayanans.split("_")

    verifikasi_pelayanan_lains = VerifikasiPelayananLain.where(:kode_verifikasi => kode_verifikasi)
    if tmp_kode.length > verifikasi_pelayanan_lains.length || tmp_kode.length < verifikasi_pelayanan_lains.length
      verifikasi_pelayanan_lains.destroy_all
    end

    i = 0
    tmp_kode.each do |kode|
      #puts "===============#{i}==#{kode}==#{tmp_kode[1]}===================================="
      tgl = tmp_tgl_pelayanan_lain[i].strip rescue ''
      kode = kode.strip rescue ''
      jumlah = tmp_jumlah[i].strip rescue 0
      nama = tmp_nama[i].strip rescue ''
      harga_satuan = tmp_harga[i].strip rescue 0
      no_transaksi = tmp_no_transaksi[i].strip rescue ''

      verifikasi_pelayanan_lain = VerifikasiPelayananLain.find_by_kode_verifikasi_and_no_transaksi(kode_verifikasi,no_transaksi)
      if verifikasi_pelayanan_lain.nil?
        verifikasi_pelayanan_lain = VerifikasiPelayananLain.new
        verifikasi_pelayanan_lain.kode_verifikasi = kode_verifikasi
      else
      end

      verifikasi_pelayanan_lain.kode_pelayanan_lain_rs = kode
      verifikasi_pelayanan_lain.nama_pelayanan_lain_rs = nama
      verifikasi_pelayanan_lain.jumlah_pelayanan_lain_rs = jumlah.to_i rescue 0
      verifikasi_pelayanan_lain.tgl_pelayanan_lain_rs = tgl
      verifikasi_pelayanan_lain.satuan_tarif = harga_satuan.to_f rescue 0
      verifikasi_pelayanan_lain.sub_total_tarif = verifikasi_pelayanan_lain.satuan_tarif * verifikasi_pelayanan_lain.jumlah_pelayanan_lain_rs 
      verifikasi_pelayanan_lain.no_transaksi = no_transaksi

      verifikasi_pelayanan_lain.save
      i=i+1
    end
  end

  def sent_to_ejkbm
    gagal_terkirim = Array.new

    check_boxs = params[:check_box]
    check_boxs.each do |kode_verifikasi|
      verifikasi = Verifikasi.find_by_kode(kode_verifikasi)
      if verifikasi.sent_to_ejkbm == false
        Verifikasi.send_to_ejkbm(verifikasi)
      end
    end

    respond_to do |format|
      if gagal_terkirim.empty?
        notice = "Data telah dikirim"
      else
        notice = "Terjadi kesalahan pada pengiriman data"
      end
      format.html { redirect_to(:action => :index, :id => "kirim", :notice => notice) }
      format.xml  { }
    end
  end

  def sent_to_rs
    gagal_terkirim = Array.new
    no_data = false

    if params[:check_box]
      check_boxs = params[:check_box]
      check_boxs.each do |kode_verifikasi|
        #puts "===============#{kode_verifikasi}===================="
        verifikasi = Verifikasi.find_by_kode(kode_verifikasi)
        if verifikasi.status_verifikasi_verifikator == 1
          gagal_terkirim << "No Reg "+verifikasi.no_reg+" sudah layak maka harus dikirim ke EJKBM terlebih dahulu"
        else
          if Verifikasi.send_to_rs(verifikasi)
          else
            gagal_terkirim << "No Reg "+verifikasi.no_reg+" gagal terkirim ke RS"
          end
        end
      end
    else
      no_data = true
    end

    respond_to do |format|
      if gagal_terkirim.empty?
        if no_data
          notice = "Tidak ada data yang dikirim"
        else
          notice = "Data telah dikirim"
        end
        format.html { redirect_to(:action => :index, :id => "kirim", :notice => notice) }
      else
        alert = ''
        gagal_terkirim.each do |pesan|
          if alert == ''
            alert = pesan
          else
            alert = alert+"<br/>"+pesan
          end
        end
        format.html { redirect_to(:action => :index, :id => "kirim", :alert => alert) }
      end
      
      format.xml  { }
     end
  end

  def sent_to_rs_ejkbm
    gagal_terkirim = Array.new
    no_data = false

    if params[:check_box]
      check_boxs = params[:check_box]
      check_boxs.each do |kode_verifikasi|
        Verifikasi.transaction do
          verifikasi = Verifikasi.find_by_kode(kode_verifikasi)
          if verifikasi.sent_to_rs == true && verifikasi.sent_to_ejkbm == false
            gagal_terkirim << "No Reg "+verifikasi.no_reg+" gagal terkirim ke EJKBM karena masih menunggu perbaikan dari RS"
          else
            #elsif verifikasi.sent_to_rs == false && verifikasi.sent_to_ejkbm == false
            if Verifikasi.send_to_ejkbm(verifikasi)
              if Verifikasi.send_to_rs(verifikasi)
              else
                gagal_terkirim << "No Reg "+verifikasi.no_reg+" gagal terkirim ke RS"
              end
            else
              gagal_terkirim << "No Reg "+verifikasi.no_reg+" gagal terkirim ke EJKBM"
            end
          #else
          #  gagal_terkirim << "No Klaim "+verifikasi.no_klaim_rs+" gagal terkirim"
          end
        end
      end
    else
      no_data = true
    end

    respond_to do |format|
      if gagal_terkirim.empty?
        if no_data
          notice = "Tidak ada data yang dikirim"
        else
          notice = "Data telah dikirim"
        end
        format.html { redirect_to(:action => :index, :id => "kirim", :notice => notice) }
      else
        alert = ''
        gagal_terkirim.each do |pesan|
          if alert == ''
            alert = pesan
          else
            alert = alert+"<br/>"+pesan
          end
        end
        format.html { redirect_to(:action => :index, :id => "kirim", :alert => alert) }
      end   
      format.xml  { }
     end
  end

  def ambil_data_kepersetaan_ejkbm
   @status = Verifikasi.ambil_data_kepersetaan_ejkbm
   respond_to do |format|
    format.html {  }
    format.xml  { }
   end
  end

  def sent_to_ejkbm_first
   VerifikasiToEjkbmFirst.sent_to_ejkbm_first_time
   respond_to do |format|
    format.html {  }
    format.xml  { }
   end
  end

end
