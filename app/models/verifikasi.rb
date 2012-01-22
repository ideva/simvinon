class Verifikasi < ActiveRecord::Base
  @@recently_save = false
  # status_verifikasi_verifikator = 0 - belum diproses atau data baru
  # status_verifikasi_verifikator = 1 - Sukses
  # status_verifikasi_verifikator = 2 - Gagal

  # status_pengiriman = 0 -> data baru
  # status_pengiriman = 1 -> data telah diproses, siap dikirim, dapat diedit
  # status_pengiriman = 2 -> data telah dikirim ke RS dan EJKBM, tidak dapat diedit lagi
  # status_pengiriman = 3 -> data telah dikirim ke RS, tidak dapat diedit lagi

  before_save :asign_iduser, :assign_0
  
  include UserInfo
  belongs_to :user, :foreign_key => "iduser"
  def asign_iduser
    if current_user_id
      self.iduser = current_user_id
    end
  end

  def assign_0
    if self.lama_dirawat.nil?
      self.lama_dirawat = 0
    end
  end

  validates_uniqueness_of :kode, :case_sensitive => false, :message => "Kode telah digunakan"
  def upper_case_kode
    self.kode.upcase!
  end
  
  before_create :generate_code
  def generate_code
    @@recently_save = true
    kode = code_generator(AWALAN_KODE, 5) #code_generator(param, length)
    if self.class.find_by_kode(kode).nil?
      self.kode = kode
      #self.save
    else
      generate_code
    end
  end

  #after_create :simpan_to_verifikasi_ejkbm_first
  def self.simpan_to_verifikasi_ejkbm_first(verifikasi)
    verifikasi_to_ejkbm_first = VerifikasiToEjkbmFirst.new
    verifikasi_to_ejkbm_first.post_param = param_verifikasi_ejkbm(verifikasi).to_s
    verifikasi_to_ejkbm_first.kode_verifikasi = verifikasi.kode
    verifikasi_to_ejkbm_first.sent_to_ejkbm = false
    verifikasi_to_ejkbm_first.save
  end

  has_many :verifikasi_obats
  has_many :verifikasi_tindakans
  belongs_to :alasan_verifikasi, :foreign_key => "kode_alasan_verifikasi", :class_name => "AlasanVerifikasi", :primary_key => "kode"
  belongs_to :kabupaten, :foreign_key => "kode_kabupaten", :class_name => "Kabupaten", :primary_key => "kode"
  belongs_to :jenis_pelayanan, :foreign_key => "kode_jenis_pelayanan", :class_name => "JenisPelayanan", :primary_key => "kode"
  belongs_to :ru_pusk, :foreign_key => "kode_ru_pusk", :class_name => "RuPusk", :primary_key => "kode"

  def verifikasi_sukses_and_gagal
    if self.status_verifikasi_verifikator == 1 || self.status_verifikasi_verifikator == 2
      return true
    else
      return false
    end
  end

  def sent_to_ejkbm_text
    if sent_to_ejkbm
      "Terkirim"
    else
      "Belum"
    end
  end

  def sent_to_rs_text
    if sent_to_rs
      "Terkirim"
    else
      "Belum"
    end
  end

  def status_verifikasi_kode
    if self.status_verifikasi_verifikator.to_s == "0"
      return "0"
    elsif self.status_verifikasi_verifikator.to_s == "1"
      return "1" # Layak
    elsif self.status_verifikasi_verifikator.to_s == "2"
      return "0" # Tidak Layak
    elsif self.status_verifikasi_verifikator.to_s == "3"
      return "2"
    end
  end

  def status_verifikasi
    if self.status_verifikasi_verifikator == 0
      return "Baru"
    elsif self.status_verifikasi_verifikator == 1
      return "Layak"
    elsif self.status_verifikasi_verifikator == 2
      return "Tidak Layak"
    elsif self.status_verifikasi_verifikator == 3
      return "Perbaikan"
    end
  end

  def respon_verifikasi_sistem_xml
    if self.status_verifikasi_sistem
      return "1"
    else
      return "0"
    end
  end

  def respon_verifikasi_sistem
    if self.status_verifikasi_sistem
      return "Sukses"
    else
      return "Gagal"
    end
  end

  def self.set_status_verifikasi_global_verifikator(kode_verifikasi)
    status_gagal = false 
      if VerifikasiPemeriksaan.exists?(:status_verifikasi_verifikator => 2, :kode_verifikasi => kode_verifikasi)
        status_gagal = true
      end
      if VerifikasiObat.exists?(:status_verifikasi_verifikator => 2, :kode_verifikasi => kode_verifikasi)
        status_gagal = true
      end
      if VerifikasiTindakan.exists?(:status_verifikasi_verifikator => 2, :kode_verifikasi => kode_verifikasi)
        status_gagal = true
      end
      if VerifikasiPelayananLain.exists?(:status_verifikasi_verifikator => 2, :kode_verifikasi => kode_verifikasi)
        status_gagal = true
      end

    verifikasi = Verifikasi.find_by_kode(kode_verifikasi)
      if status_gagal
        verifikasi.status_verifikasi_verifikator = 2
      else
        verifikasi.status_verifikasi_verifikator = 1
      end
      verifikasi.save
  end

  def self.set_status_verifikasi_global_sistem(kode_verifikasi)
    status_gagal = true
      if VerifikasiPemeriksaan.where(:status_verifikasi_sistem => 2, :kode_verifikasi => kode_verifikasi).empty?
        status_gagal = false
      end
      if VerifikasiObat.where(:status_verifikasi_sistem => 2, :kode_verifikasi => kode_verifikasi).empty?
        status_gagal = false
      end
      if VerifikasiTindakan.where(:status_verifikasi_sistem => 2, :kode_verifikasi => kode_verifikasi).empty?
        status_gagal = false
      end
      if VerifikasiPelayananLain.where(:status_verifikasi_sistem => 2, :kode_verifikasi => kode_verifikasi).empty?
        status_gagal = false
      end

      verifikasi = Verifikasi.find_by_kode(kode_verifikasi)
      if status_gagal == true
        verifikasi.status_verifikasi_sistem = true
      else
        verifikasi.status_verifikasi_sistem = false
      end
      #puts "=============================#{verifikasi.status_verifikasi_sistem}============================="
      verifikasi.save
  end

  after_save :set_log
  def set_log
    if @@recently_save == false
    kode_verifikasi = self.kode
    verifikasi_log = VerifikasiLog.new
    verifikasi_lama = Verifikasi.find_by_kode(kode_verifikasi)
    verifikasi_log.kode_verifikasi = kode_verifikasi
    verifikasi_log.status_verifikasi_verifikator_sebelum = verifikasi_lama.status_verifikasi_verifikator rescue 0
    verifikasi_log.status_verifikasi_verifikator_sesudah = self.status_verifikasi_verifikator rescue 0
    verifikasi_log.save
    end
  end

  # status_verifikasi_verifikator = 0 - belum diproses atau data baru
  # status_verifikasi_verifikator = 1 - Sukses
  # status_verifikasi_verifikator = 2 - Gagal
  # status_verifikasi_verifikator = 3 - Pending
  def self.send_to_ejkbm(verifikasi='')
    uri = '-'
    parameter = '-'
    result = '-'
    
    # kirim ke ejkbm yang sukses, gagal
    if verifikasi == ''
      verifikasi = Verifikasi.where(" (status_verifikasi_verifikator = 1 || status_verifikasi_verifikator = 2) AND sent_to_ejkbm = 0").first
    end

    # Jika data sudah dikirim maka stop proses
    if verifikasi.nil?
      status = false#"Tidak ada data yang dikirim"
      return status
    end
    
    # Jika data sudah dikirim maka stop proses dan berikan statatus pengiriman berhasil
    if verifikasi.sent_to_ejkbm
      status = true
      return status
    end

    parameter = param_verifikasi_ejkbm(verifikasi)
    #puts parameter.length
#    i = 1
#    tmp_param = ""
#    parameter.each do |key,value|
#      #puts "No #{i} = #{key}-#{value}"
#      if tmp_param == ""
#        tmp_param = "#{key}"
#      else
#        tmp_param = tmp_param+"\n#{key}"
#      end
#      i = i+1
#    end

#    get_param = ""
#    parameter.each do |key,value|
#      if get_param == ""
#        get_param = "#{key}=#{value}&"
#      else
#        get_param = "#{get_param}#{key}=#{value}&"
#      end
#      #i = i+1
#    end
#    puts "GET = #{get_param}"

    unless parameter.nil? || parameter == ''   
      setting = Setting.find_by_name('URL_WS_EJKBM')    
      #full_url = "#{setting.string_value}?#{URI.escape(parameter)}"
      #puts "===To EJKBM===#{full_url}======="
      require "net/http"
      require "uri"
      require "rexml/document"

      begin
        uri = URI(setting.string_value)
        result = Net::HTTP.post_form(uri, parameter)
        result = result.body

        x = REXML::Document.new result.to_s
        status =  x.root.elements['/boolean'].text
        if status.to_s == "true"
          #verifikasi.status_pengiriman = 2
          verifikasi.sent_to_ejkbm = true
          status = true
        else
          verifikasi.status_pengiriman = 1
          verifikasi.sent_to_ejkbm = false
          status = false
        end
        verifikasi.save

#        verifikasi_to_ejkbm_first = VerifikasiToEjkbmFirst.find_by_kode_verifikasi(verifikasi.kode)
#        if verifikasi_to_ejkbm_first.nil?
#          verifikasi_to_ejkbm_first = VerifikasiToEjkbmFirst.new
#          verifikasi_to_ejkbm_first.kode_verifikasi = verifikasi.kode
#          verifikasi_to_ejkbm_first.post_param = parameter.to_s rescue ''
#          verifikasi_to_ejkbm_first.sent_to_ejkbm = false
#          verifikasi_to_ejkbm_first.save
#        end
      rescue
        status = false
      end
    else
      status = false
    end

    verifikasi_log = VerifikasiRequestLog.new
    verifikasi_log.request_out = "\n--URL-------\n"+uri.to_s+"\n--Parameter POST-------\n"+parameter.to_s+"\n--Result-------\n"+result
    verifikasi_log.save

    return status
  end

  # status_verifikasi_verifikator = 0 - belum diproses atau data baru
  # status_verifikasi_verifikator = 1 - Sukses
  # status_verifikasi_verifikator = 2 - Gagal
  # status_verifikasi_verifikator = 3 - Pending
  def self.send_to_rs(verifikasi='')
    uri = '-'
    parameter = '-'
    result = '-'
    # kirim ke rs yang sukses, gagal dan perbaikan
    if verifikasi == ''
      verifikasi = Verifikasi.where("status_verifikasi_verifikator > 0 AND sent_to_rs = 0 AND sent_to_ejkbm = 0").first
    end
    #parameter = param_verifikasi(verifikasi)
    #unless parameter.nil? || parameter == ''
    if verifikasi.nil? 
      status = false#"Tidak ada data yang dikirim"
    else
      if verifikasi.sent_to_rs
        if verifikasi.sent_to_ejkbm
          verifikasi.status_pengiriman = 2 # Diset jika ke EJKBM sudah terkirim
        end
        status = true
        return status
      end
      setting = Setting.find_by_name('URL_WS_SIM_RS')
      parameter = param_verifikasi_rs(verifikasi)
      #puts parameter.length
#--------------------------------------------
#      i = 1
#      tmp_param = ""
#      parameter.each do |key,value|
#        #puts "No #{i} = #{key}-#{value}"
#        if tmp_param == ""
#          tmp_param = "#{key}"
#        else
#          tmp_param = tmp_param+"\n#{key}"
#        end
#        i = i+1
#      end
#--------------------------------------------

      #full_url = "#{setting.string_value}?#{URI.escape(parameter)}"
      puts "===To RS===#{setting.string_value}======="
      require "net/http"
      require "uri"
      require "rexml/document"
      #puts "-- #{full_url} --"
      begin
        #result = Net::HTTP.get(URI.parse(full_url))
        uri = URI(setting.string_value)
        result = Net::HTTP.post_form(uri, parameter)
        result = result.body

        x = REXML::Document.new result.to_s
        status =  x.root.elements['/verifikasi/status_pengiriman'].text

        if status.to_s == "1"
          if verifikasi.sent_to_ejkbm
            verifikasi.status_pengiriman = 2 # Diset jika ke EJKBM sudah terkirim
          end
          verifikasi.sent_to_rs = true
          status = true
        else
          verifikasi.status_pengiriman = 1
          verifikasi.sent_to_rs = false
          status = false
        end  
        verifikasi.save 
      rescue
        verifikasi.sent_to_rs = false
        status = false
      end
    end

    verifikasi_log = VerifikasiRequestLog.new
    verifikasi_log.request_out = "\n--URL-------\n"+uri.to_s+"\n--Parameter POST-------\n"+parameter.to_s+"\n--Result-------\n"+result
    verifikasi_log.save

    return status
    # @verifikasi = verifikasi
  end

  def self.param_verifikasi_ejkbm(verifikasi)
    
    unless verifikasi.nil?
      status_verifikasi_global = verifikasi.status_verifikasi_kode.to_s rescue ''
      komentar_verifikasi_global = verifikasi.komentar.to_s rescue ''
      total_tarif = verifikasi.total_tarif.to_s rescue ''
      no_klaim = verifikasi.no_klaim_rs.to_s rescue ''
      no_reg = verifikasi.no_reg.to_s rescue ''
      no_ejkbm = verifikasi.no_ejkbm.to_s rescue ''
      nik = verifikasi.nik.to_s rescue ''
      no_kk = verifikasi.no_kk.to_s rescue ''
      no_ktp = verifikasi.ktp.to_s rescue ''
      nama_pasien = verifikasi.nama_pasien rescue ''

      norm = verifikasi.norm.to_s rescue ''
      tgl_masuk = verifikasi.tgl_masuk.to_date.strftime("%m-%d-%Y") rescue '01-01-2012'
      tgl_keluar = verifikasi.tgl_keluar.to_date.strftime("%m-%d-%Y") rescue '01-01-2012'
      lama_dirawat = verifikasi.lama_dirawat.to_s rescue ''
      kode_instalasi_layanan = verifikasi.kode_instalasi_layanan.to_s rescue ''
      nama_instalasi_layanan = verifikasi.nama_instalasi_layanan.to_s rescue ''
      nama_dokter = verifikasi.dokter.to_s rescue ''
      keluhan = verifikasi.keluhan.to_s rescue ''
      diagnosa_icd = verifikasi.diagnosa_icd.to_s rescue ''
      jenis_pelayanan = verifikasi.kode_jenis_pelayanan.to_s rescue ''

      kode_rs_pusk = verifikasi.kode_ru_pusk.to_s rescue ''
      kode_kabupaten = verifikasi.kode_kabupaten.to_s rescue ''

      #kode_alasan_verifikasi = verifikasi.kode_alasan_verifikasi
      #alasan_verifikasi = verifikasi.alasan_verifikasi.alasan rescue ''
      #no_pelayanan = verifikasi.no_pelayanan rescue ''

      parameter = {"status_verifikasi_global" => status_verifikasi_global,
                   "komentar_verifikasi_global" => komentar_verifikasi_global,
                   "total_tarif" => total_tarif, "no_klaim" => no_klaim, "no_reg" => no_reg,
                   "no_ejkbm" => no_ejkbm, "norm" => norm, "nama_pasien" => nama_pasien,
                   "tgl_masuk" => tgl_masuk, "tgl_keluar" => tgl_keluar, "lama_dirawat" => lama_dirawat, "nik" => nik,
                   "no_kk" => no_kk, "no_ktp" => no_ktp, "nama_dokter" => nama_dokter,
                   "kode_instalasi_layanan" => kode_instalasi_layanan,
                   "nama_instalasi_layanan" => nama_instalasi_layanan, "keluhan" => keluhan,
                   "diagnosa_icd" => diagnosa_icd, "jenis_pelayanan" => jenis_pelayanan,
                   "kode_rs_pusk" => kode_rs_pusk, "kode_kabupaten" => kode_kabupaten}
      #parameter = "total_tarif=#{total_tarif}&no_klaim=#{no_klaim}&no_ejkbm=#{no_ejkbm}&norm=#{norm}&nama_pasien=#{nama_pasien}&tgl_masuk=#{tgl_masuk}&tgl_keluar=#{tgl_keluar}&lama_dirawat=#{lama_dirawat}&nik=#{nik}&nomor_kk=#{no_kk}&no_ktp=#{no_ktp}&nama_dokter=#{nama_dokter}&kode_instalasi_layanan=#{kode_instalasi_layanan}&nama_instalasi_layanan=#{nama_instalasi_layanan}&keluhan=#{keluhan}&diagnosa_icd=#{diagnosa_icd}&jenis_layanan=#{jenis_pelayanan}&kode_rs_pusk=#{kode_rs_pusk}&kode_kabupaten=#{kode_kabupaten}"
      kode_verifikasi = verifikasi.kode

      parameter.merge!(param_pemeriksaan(kode_verifikasi, "ejkbm"))
      parameter.merge!(param_tindakan_medis_ejkbm(kode_verifikasi))
      parameter.merge!(param_obat(kode_verifikasi, "ejkbm"))
      parameter.merge!(param_pelayanan_lain(kode_verifikasi))
      
#      param = ''
#      param = param_pemeriksaan_to_ejkbm(kode_verifikasi)
#      parameter = parameter+"&"+param
#      param = param_tindakan_medis_to_ejkbm(kode_verifikasi)
#      parameter = parameter+"&"+param
#      param = param_tindakan_penunjang_to_ejkbm(kode_verifikasi)
#      parameter = parameter+"&"+param
#      param = param_obat_to_ejkbm(kode_verifikasi)
#      parameter = parameter+"&"+param

      if verifikasi.status_pengiriman == 0
        param = {"flag_transaksi" => 1}
        parameter.merge!(param)
        #parameter = parameter+"&"+"flag_transaksi=1"
      elsif verifikasi.status_pengiriman == 1 && (verifikasi.status_verifikasi_verifikator == 1 || verifikasi.status_verifikasi_verifikator == 2)
        param = {"flag_transaksi" => 2}
        parameter.merge!(param)
        #parameter = parameter+"&"+"flag_transaksi=2"
      end
      
    else
      parameter = ''
    end
    return  parameter
  end

  def self.param_verifikasi_rs(verifikasi)

    unless verifikasi.nil?
      if verifikasi.sent_to_ejkbm      
      else
        verifikasi.status_verifikasi_verifikator = 3
        verifikasi.save
      end
      status_verifikasi_global = verifikasi.status_verifikasi_kode
      komentar_verifikasi_global = verifikasi.komentar
      total_tarif = verifikasi.total_tarif
      
      no_ejkbm = verifikasi.no_ejkbm
      nik = verifikasi.nik
      no_kk = verifikasi.no_kk
      no_ktp = verifikasi.ktp
      nama_pasien = verifikasi.nama_pasien rescue ''

      no_klaim = verifikasi.no_klaim_rs
      no_reg = verifikasi.no_reg
      norm = verifikasi.norm
      tgl_masuk = verifikasi.tgl_masuk
      tgl_keluar = verifikasi.tgl_keluar
      lama_dirawat = verifikasi.lama_dirawat
      kode_instalasi_layanan = verifikasi.kode_instalasi_layanan
      nama_instalasi_layanan = verifikasi.nama_instalasi_layanan
      nama_dokter = verifikasi.dokter
      keluhan = verifikasi.keluhan
      diagnosa_icd = verifikasi.diagnosa_icd
      jenis_pelayanan = verifikasi.kode_jenis_pelayanan

      kode_rs_pusk = verifikasi.kode_ru_pusk.to_s rescue ''
      kode_kabupaten = verifikasi.kode_kabupaten.to_s rescue ''

      #kode_alasan_verifikasi = verifikasi.kode_alasan_verifikasi
      #alasan_verifikasi = verifikasi.alasan_verifikasi.alasan rescue ''
      #no_pelayanan = verifikasi.no_pelayanan rescue ''

      parameter = {"status_verifikasi_global" => status_verifikasi_global,
                   "komentar_verifikasi_global" => komentar_verifikasi_global,
                   "total_tarif" => total_tarif, "no_klaim" => no_klaim, "no_reg" => no_reg,
                   "no_ejkbm" => no_ejkbm,
                   "norm" => norm, "nama_pasien" => nama_pasien, "tgl_masuk" => tgl_masuk,
                   "tgl_keluar" => tgl_keluar, "lama_dirawat" => lama_dirawat, "nik" => nik,
                   "no_kk" => no_kk, "no_ktp" => no_ktp, "nama_dokter" => nama_dokter,
                   "kode_instalasi_layanan" => kode_instalasi_layanan,
                   "nama_instalasi_layanan" => nama_instalasi_layanan, "keluhan" => keluhan,
                   "diagnosa_icd" => diagnosa_icd, "jenis_pelayanan" => jenis_pelayanan,
                   "kode_rs_pusk" => kode_rs_pusk, "kode_kabupaten" => kode_kabupaten}
      #parameter = "status_verifikasi_global=#{status_verifikasi_global}&komentar_verifikasi_global=#{komentar_verifikasi_global}&total_tarif=#{total_tarif}&no_klaim=#{no_klaim}&no_ejkbm=#{no_ejkbm}&norm=#{norm}&nama_pasien=#{nama_pasien}&tgl_masuk=#{tgl_masuk}&tgl_keluar=#{tgl_keluar}&lama_dirawat=#{lama_dirawat}&nik=#{nik}&nomor_kk=#{no_kk}&no_ktp=#{no_ktp}&nama_dokter=#{nama_dokter}&kode_instalasi_layanan=#{kode_instalasi_layanan}&nama_instalasi_layanan=#{nama_instalasi_layanan}&keluhan=#{keluhan}&diagnosa_icd=#{diagnosa_icd}&jenis_layanan=#{jenis_pelayanan}&kode_rs_pusk=#{kode_rs_pusk}&kode_kabupaten=#{kode_kabupaten}"
      kode_verifikasi = verifikasi.kode

      parameter.merge!(param_pemeriksaan(kode_verifikasi, "rs"))
      parameter.merge!(param_tindakan_medis_rs(kode_verifikasi))
      parameter.merge!(param_obat(kode_verifikasi, "rs"))
      parameter.merge!(param_pelayanan_lain(kode_verifikasi))

#      param = ''
#      param = param_pemeriksaan_to_ejkbm(kode_verifikasi)
#      parameter = parameter+"&"+param
#      param = param_tindakan_medis_to_rs(kode_verifikasi)
#      parameter = parameter+"&"+param
#      param = param_obat_to_ejkbm(kode_verifikasi)
#      parameter = parameter+"&"+param
      
    else
      parameter = ''
    end
    return  parameter
  end
#-----------------------------------------------------------
  
  def self.param_tindakan_medis_rs(kode_verifikasi)
    verifikasi_tindakan_medis = VerifikasiTindakan.where(:kode_verifikasi => kode_verifikasi)
    param = param_tindakan(verifikasi_tindakan_medis, 0)

    param_status = generate_param_status_verifikasi(verifikasi_tindakan_medis, "tm")
    #param=param+"&"+param_status
    param.merge!(param_status)

    return param
  end

  def self.param_tindakan_medis_ejkbm(kode_verifikasi)
    verifikasi_tindakan_medis = VerifikasiTindakan.where(:kode_verifikasi => kode_verifikasi, :flag => 1)
    param = param_tindakan(verifikasi_tindakan_medis, 1)
    param_status = generate_param_status_verifikasi(verifikasi_tindakan_medis, "tm")
    param.merge!(param_status)

    verifikasi_tindakan_penunjangs = VerifikasiTindakan.where(:kode_verifikasi => kode_verifikasi, :flag => 2)
    param_tp = param_tindakan(verifikasi_tindakan_penunjangs, 2)
    param_status = generate_param_status_verifikasi(verifikasi_tindakan_penunjangs, "tp")
    param_tp.merge!(param_status)

    param.merge!(param_tp)
    return param
  end

  def self.param_tindakan(verifikasi_tindakan_medis, flag)
    
    param_jumlah = ""
    verifikasi_tindakan_medis.each do |verifikasi_tindakan_medi|
      if param_jumlah == ""
        param_jumlah = verifikasi_tindakan_medi.jumlah_t_medis_rs.to_s rescue "0"
      else
        param_jumlah = "#{param_jumlah rescue "0"}_#{verifikasi_tindakan_medi.jumlah_t_medis_rs rescue "0"}"
      end
    end
    param_tarif = ""
    verifikasi_tindakan_medis.each do |verifikasi_tindakan_medi|
      if param_tarif == ""
        param_tarif = verifikasi_tindakan_medi.satuan_tarif_ejkbm.to_s rescue "0"
      else
        param_tarif = "#{param_tarif.to_s rescue "0"}_#{verifikasi_tindakan_medi.satuan_tarif_ejkbm.to_s rescue "0"}"
      end
    end
    param_tanggal = ""
    verifikasi_tindakan_medis.each do |verifikasi_tindakan_medi|
      if param_tanggal == ""
        param_tanggal = verifikasi_tindakan_medi.tgl_t_medis_rs.to_s rescue "-"
      else
        param_tanggal = "#{param_tanggal.to_s rescue "-"}_#{verifikasi_tindakan_medi.tgl_t_medis_rs.to_s rescue "-"}"
      end
    end

    if flag == '' || flag == 0 # RS
      param_kode = ""
      verifikasi_tindakan_medis.each do |verifikasi_tindakan_medi|
        if param_kode == ""
          param_kode = verifikasi_tindakan_medi.kode_t_medis_rs
        else
          param_kode = param_kode+"_"+verifikasi_tindakan_medi.kode_t_medis_rs
        end
      end
      param_kode_hash = {"kode_tm" => param_kode}
      param_tanggal_hash = {"tgl_tm" => param_tanggal}
      param_tarif_hash = {"jumlah_tm" => param_jumlah, "tarif_tm" => param_tarif}
    else
      param_kode = ""
      verifikasi_tindakan_medis.each do |verifikasi_tindakan_medi|
        if param_kode == ""
          param_kode = verifikasi_tindakan_medi.kode_t_medis_ejkbm
        else
          param_kode = param_kode+"_"+verifikasi_tindakan_medi.kode_t_medis_ejkbm
        end
      end
      if flag == 1 # EJKBM T.Medis
        param_kode_hash = {"kode_tm" => param_kode}
        param_tanggal_hash = {"tgl_tm" => param_tanggal}
        param_tarif_hash = {"jumlah_tm" => param_jumlah, "tarif_tm" => param_tarif}
      else # EJKBM T.Penunjang
        param_kode_hash = {"kode_tp" => param_kode}
        param_tanggal_hash = {"tgl_tp" => param_tanggal}
        param_tarif_hash = {"jumlah_tp" => param_jumlah, "tarif_tp" => param_tarif}
      end
    end

    param = param_tarif_hash
    param.merge!(param_kode_hash)
    param.merge!(param_tanggal_hash)
    
    return param
  end

  def self.param_pemeriksaan(kode_verifikasi, flag)
    verifikasi_pemeriksaans = VerifikasiPemeriksaan.where(:kode_verifikasi => kode_verifikasi)

    param_kode = ""
    if flag == "ejkbm"
      verifikasi_pemeriksaans.each do |verifikasi_pemeriksaan|
        if param_kode == ""
          param_kode = verifikasi_pemeriksaan.kode_pemeriksaan_ejkbm.to_s rescue ''
        else
          param_kode = param_kode+"_"+(verifikasi_pemeriksaan.kode_pemeriksaan_ejkbm.to_s rescue '')
        end
      end
    else # RS
      verifikasi_pemeriksaans.each do |verifikasi_pemeriksaan|
        if param_kode == ""
          param_kode = verifikasi_pemeriksaan.kode_pemeriksaan_rs.to_s rescue ''
        else
          param_kode = param_kode+"_"+(verifikasi_pemeriksaan.kode_pemeriksaan_rs.to_s rescue '')
        end
      end
    end

    param_tarif = ""
    verifikasi_pemeriksaans.each do |verifikasi_pemeriksaan|
      if param_tarif == ""
        param_tarif = verifikasi_pemeriksaan.pemeriksaan.tarif.to_s rescue ''
      else
        param_tarif = "#{param_tarif rescue "0"}_#{verifikasi_pemeriksaan.pemeriksaan.tarif.to_s rescue ''}"
      end
    end

    param_jumlah_hari = ""
    verifikasi_pemeriksaans.each do |verifikasi_pemeriksaan|
      if param_jumlah_hari == ""
        param_jumlah_hari = (verifikasi_pemeriksaan.jumlah.to_i rescue "0")
      else
        param_jumlah_hari = "#{param_jumlah_hari rescue "0"}_#{ (verifikasi_pemeriksaan.jumlah.to_i rescue "0") }"
      end
    end

    param = {"kode_pemeriksaan" => param_kode,
             "jumlah_hari" => param_jumlah_hari,
             "tarif_pemeriksaan" => param_tarif}
    param.merge!(generate_param_status_verifikasi(verifikasi_pemeriksaans, "pemeriksaan"))

    return param
  end

  def self.param_obat(kode_verifikasi, flag)
    verifikasi_obats = VerifikasiObat.where(:kode_verifikasi => kode_verifikasi)
    param_kode = ""
    if flag == "ejkbm"
      verifikasi_obats.each do |verifikasi_obat|
        #unless verifikasi_obat.kode_obat_ejkbm.nil?
          if param_kode == ""
            param_kode = verifikasi_obat.kode_obat_ejkbm.to_s rescue ''
          else
            param_kode = param_kode+"_"+(verifikasi_obat.kode_obat_ejkbm.to_s rescue '')
          end
        #end
      end
    else
      verifikasi_obats.each do |verifikasi_obat|
        #unless verifikasi_obat.kode_obat_ejkbm.nil?
          if param_kode == ""
            param_kode = verifikasi_obat.kode_obat_rs
          else
            param_kode = param_kode+"_"+verifikasi_obat.kode_obat_rs
          end
        #end
      end
    end

    param_jumlah = ""
    verifikasi_obats.each do |verifikasi_obat|
      #unless verifikasi_obat.kode_obat_ejkbm.nil?
        if param_jumlah == ""
          param_jumlah = verifikasi_obat.jumlah_obat_rs
        else
          param_jumlah = "#{param_jumlah.to_s rescue "0"}_#{verifikasi_obat.jumlah_obat_rs rescue "0"}"
        end
      #end
    end
    param_tarif = ""
    verifikasi_obats.each do |verifikasi_obat|
      #unless verifikasi_obat.kode_obat_ejkbm.nil?
        if param_tarif == ""
          param_tarif = verifikasi_obat.satuan_tarif_ejkbm
        else
          param_tarif = "#{param_tarif.to_s rescue "0"}_#{verifikasi_obat.satuan_tarif_ejkbm rescue "0"}"
        end
      #end
    end
    param_tanggal = ""
    verifikasi_obats.each do |verifikasi_obat|
      #unless verifikasi_obat.kode_obat_ejkbm.nil?
        if param_tanggal == ""
          param_tanggal = verifikasi_obat.tgl_obat.to_s rescue "-"
        else
          param_tanggal = "#{param_tanggal.to_s rescue "-"}_#{verifikasi_obat.tgl_obat.to_s rescue "-"}"
        end
      #end
    end

    param = {"kode_obat" => param_kode, "jumlah_obat" => param_jumlah, 
             "tarif_obat" => param_tarif, "tgl_obat" => param_tanggal}
    param_status = generate_param_status_verifikasi(verifikasi_obats, "obat")
    param.merge!(param_status)
    #param = "kode_obat=#{param_kode}&jumlah_obat=#{param_jumlah}&tarif_obat=#{param_tarif}"
    #param_status = generate_param_status_verifikasi(verifikasi_obats, "obat")
    #param=param+"&"+param_status

    return param
  end

  # Akan selalu menggunakan kode RS
  def self.param_pelayanan_lain(kode_verifikasi)
    verifikasi_pelayanan_lains = VerifikasiPelayananLain.where(:kode_verifikasi => kode_verifikasi)

    param_kode = ""
    verifikasi_pelayanan_lains.each do |verifikasi_pl|
      unless verifikasi_pl.kode_pelayanan_lain_rs.nil?
        if param_kode == ""
          param_kode = verifikasi_pl.kode_pelayanan_lain_rs.to_s rescue "-"
        else
          param_kode = "#{param_kode.to_s rescue "-"}_#{verifikasi_pl.kode_pelayanan_lain_rs.to_s rescue "-"}"
        end
      end
    end
    param_nama = ""
    verifikasi_pelayanan_lains.each do |verifikasi_pl|
      unless verifikasi_pl.kode_pelayanan_lain_rs.nil?
        if param_nama == ""
          param_nama = verifikasi_pl.nama_pelayanan_lain_rs.to_s rescue "-"
        else
          param_nama = "#{param_nama.to_s rescue "-"}_#{verifikasi_pl.nama_pelayanan_lain_rs.to_s rescue "-"}"
        end
      end
    end
    param_jumlah = ""
    verifikasi_pelayanan_lains.each do |verifikasi_pl|
      unless verifikasi_pl.kode_pelayanan_lain_rs.nil?
        if param_jumlah == ""
          param_jumlah = verifikasi_pl.jumlah_pelayanan_lain_rs.to_s rescue "0"
        else
          param_jumlah = "#{param_jumlah.to_s rescue "-"}_#{verifikasi_pl.jumlah_pelayanan_lain_rs.to_s rescue "0"}"
        end
      end
    end
    param_tarif = ""
    verifikasi_pelayanan_lains.each do |verifikasi_pl|
      unless verifikasi_pl.kode_pelayanan_lain_rs.nil?
        if param_tarif == ""
          param_tarif = verifikasi_pl.satuan_tarif.to_s rescue "0"
        else
          param_tarif = "#{param_tarif.to_s rescue "-"}_#{verifikasi_pl.satuan_tarif.to_s rescue "0"}"
        end
      end
    end
    param_tanggal = ""
    verifikasi_pelayanan_lains.each do |verifikasi_pl|
      unless verifikasi_pl.kode_pelayanan_lain_rs.nil?
        if param_tanggal == ""
          param_tanggal = verifikasi_pl.tgl_pelayanan_lain_rs.to_s rescue "-"
        else
          param_tanggal = "#{param_tanggal.to_s rescue "-"}_#{verifikasi_pl.tgl_pelayanan_lain_rs.to_s rescue "-"}"
        end
      end
    end

    param = {"kode_pl" => param_kode, "nama_pl" => param_nama, "jumlah_pl" => param_jumlah,
             "harga_satuan_pl" => param_tarif, "tgl_pl" => param_tanggal}
    param_status = generate_param_status_verifikasi(verifikasi_pelayanan_lains, "pl")
    param.merge!(param_status)

    return param
  end

  def self.generate_param_status_verifikasi(objects, param)
    param_status = ""
    objects.each do |object|
      if param_status == ""
        param_status = object.status_verifikasi_xml.to_s rescue ''
      else
        param_status = param_status+"_"+(object.status_verifikasi_xml.to_s rescue '')
      end
    end

    param_kode_alasan = ""
    objects.each do |object|
      if object.status_verifikasi_verifikator == 1
        if param_kode_alasan == ""
          param_kode_alasan = "-"
        else
          param_kode_alasan = param_kode_alasan +"_"+"-"
        end
      else
        if param_kode_alasan == ""
          param_kode_alasan = (object.kode_alasan_verifikasi.nil? == true ? '-' : object.kode_alasan_verifikasi) rescue '-'
        else
          param_kode_alasan = param_kode_alasan+"_"+((object.kode_alasan_verifikasi.nil? == true ? '-' : object.kode_alasan_verifikasi) rescue '-')
        end
      end
    end

    param_komentar = ""
    objects.each do |object|
      if object.status_verifikasi_verifikator == 1
        if param_komentar == ""
          param_komentar = "-"
        else
          param_komentar = param_komentar +"_"+"-"
        end
      else
        if param_komentar == ""
          param_komentar = ( (object.komentar.nil? || object.komentar == "" ) == true ? '-' : object.komentar) rescue '-'
        else
          param_komentar = param_komentar+"_"+( (object.komentar.nil? || object.komentar == "" )  == true ? '-' : object.komentar) rescue '-'
        end
      end
    end

    param_no_transaksi = ""
    objects.each do |object|
      if param_no_transaksi == ""
        param_no_transaksi = object.no_transaksi.to_s rescue '-'
      else
        param_no_transaksi = param_no_transaksi+"_"+(object.no_transaksi.to_s rescue '-')
      end
    end

    param = { "no_transaksi_#{param}" => param_no_transaksi,
              "status_verifikasi_#{param}" => param_status,
              "kode_alasan_#{param}" => param_kode_alasan,
              "komentar_#{param}" => param_komentar             
            }
    #param = "no_transaksi_#{param}=#{param_no_transaksi}&status_verifikasi_#{param}=#{param_status}&kode_alasan_#{param}=#{param_kode_alasan}&komentar_#{param}=#{param_komentar}"
    return param
  end

end
