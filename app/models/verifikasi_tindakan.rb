class VerifikasiTindakan < ActiveRecord::Base
  # flag = 1 - data tindakan medis
  # flag = 2 - data tindakan penunjang
  # flag = 3 - data tidak ditemukan dalam mapping

  include UserInfo
  belongs_to :user, :foreign_key => "iduser"
  before_save :asign_iduser
  def asign_iduser
    if current_user_id
      self.iduser = current_user_id
    end
  end

  validates_uniqueness_of :kode, :case_sensitive => false, :message => "Kode telah digunakan"
  before_create :generate_code
  def generate_code
    kode = code_generator(AWALAN_KODE, 5) #code_generator(param, length)
    if self.class.find_by_kode(kode).nil?
      self.kode = kode
      #self.save
    else
      generate_code
    end
  end

 belongs_to :verifikasi, :foreign_key => "kode_verifikasi",
             :class_name => "Verifikasi", :primary_key => "kode"
 belongs_to :tindakan_medi, :foreign_key => "kode_t_medis_ejkbm",
             :class_name => "TindakanMedi", :primary_key => "kode"
 belongs_to :tindakan_penunjang, :foreign_key => "kode_t_medis_ejkbm",
             :class_name => "TindakanPenunjang", :primary_key => "kode"
 belongs_to :pemeriksaan, :foreign_key => "kode_t_medis_ejkbm",
             :class_name => "Pemeriksaan", :primary_key => "kode"
 belongs_to :alasan_verifikasi, :foreign_key => "kode_alasan_verifikasi",
             :class_name => "AlasanVerifikasi", :primary_key => "kode"

  def status_verifikasi
    if self.status_verifikasi_verifikator == 0
      return "Belum terproses"
    elsif self.status_verifikasi_verifikator == 1
      return "Layak"
    elsif self.status_verifikasi_verifikator == 2
      return "Tidak Layak"
    elsif self.status_verifikasi_verifikator == 3
      return "Perbaikan"
    end
  end

  def status_verifikasi_xml
    if self.status_verifikasi_verifikator == 1
      return "1"
    else
      return "0"
    end
  end

  before_save :set_mapping, :clear_alasan
  def set_mapping
    total_tarif = 0

    mapping_data_tindakan = MappingDataTindakanMedi.find_by_kode_rs(self.kode_t_medis_rs)
    mapping_data_tindakan_penunjang = MappingDataTindakanPenunjang.find_by_kode_rs(self.kode_t_medis_rs)

    if mapping_data_tindakan.nil? && mapping_data_tindakan_penunjang.nil?
      self.satuan_tarif_ejkbm = 0
      self.sub_total_tarif_ejkbm = 0
      self.flag = 3 # tidak ditemukan dalam mapping
    else
      tindakan_medis = TindakanMedi.find_by_kode( (mapping_data_tindakan.kode_ejkbm rescue '') )
      if tindakan_medis.nil?
        tindakan_penunjang = TindakanPenunjang.find_by_kode( (mapping_data_tindakan_penunjang.kode_ejkbm rescue '') )
        if tindakan_penunjang.nil?
          self.flag = 3 # data tidak ditemukan dalam mapping
          tarif_satuan = 0
          kode_ejkbm = ''
        else
          self.flag = 2 # data tindakan penunjang
          self.status_verifikasi_sistem = 1
          tarif_satuan = tindakan_penunjang.tarif
          kode_ejkbm = tindakan_penunjang.kode
        end
      else
        self.flag = 1 # data tindakan medis
        self.status_verifikasi_sistem = 1
        tarif_satuan = tindakan_medis.tarif
        kode_ejkbm = tindakan_medis.kode
      end

        self.satuan_tarif_ejkbm = tarif_satuan
        self.kode_t_medis_ejkbm = kode_ejkbm

        total_tarif = tarif_satuan * self.jumlah_t_medis_rs
        self.sub_total_tarif_ejkbm = total_tarif
    end
  end

  def clear_alasan
    if self.status_verifikasi_verifikator == 1
      self.komentar = ''
      self.kode_alasan_verifikasi = nil
    end
  end

end
