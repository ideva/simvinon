class VerifikasiPemeriksaan < ActiveRecord::Base
  # flag = 1 - data ada
  # flag = 2 - data tidak ditemukan dalam mapping

  include UserInfo
  belongs_to :user, :foreign_key => "iduser"
  before_save :asign_iduser
  def asign_iduser
    if current_user_id
      self.iduser = current_user_id
    end
  end

  validates_uniqueness_of :kode, :case_sensitive => false, :message => "Kode telah digunakan"
  def upper_case_kode
    self.kode.upcase!
  end
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
 belongs_to :pemeriksaan, :foreign_key => "kode_pemeriksaan_ejkbm",
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
    status_mapping = false

    mapping_pemeriksaan = MappingDataPemeriksaan.find_by_kode_pemeriksaan_rs(self.kode_pemeriksaan_rs)
    if mapping_pemeriksaan.nil?
      #self.satuan_tarif_ejkbm = 0
      self.sub_total_tarif_ejkbm = 0
      self.flag = 2
    else
      pemeriksaan = Pemeriksaan.find_by_kode(mapping_pemeriksaan.kode_pemeriksaan_ejkbm)
      self.kode_pemeriksaan_ejkbm = pemeriksaan.kode
      self.tarif_pemeriksaan = pemeriksaan.tarif
      self.sub_total_tarif_ejkbm = pemeriksaan.tarif * self.jumlah
      self.flag = 1
      self.status_verifikasi_sistem = 1
      self.status_verifikasi_sistem = true
    end
  end

  def clear_alasan
    if self.status_verifikasi_verifikator == 1
      self.komentar = ''
      self.kode_alasan_verifikasi = nil
    end
  end

end
