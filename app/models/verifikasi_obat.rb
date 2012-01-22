class VerifikasiObat < ActiveRecord::Base
  # flag = 1 - data obat
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

  def status_verifikasi
    if self.flag == 1
      return "Sukses"
    elsif self.flag == 2
      return "Gagal"
    end
  end

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

  belongs_to :verifikasi, :foreign_key => "kode_verifikasi",
             :class_name => "Verifikasi", :primary_key => "kode"
  belongs_to :obat, :foreign_key => "kode_obat_ejkbm",
             :class_name => "Obat", :primary_key => "kode"
  belongs_to :alasan_verifikasi, :foreign_key => "kode_alasan_verifikasi",
             :class_name => "AlasanVerifikasi", :primary_key => "kode"

  def check_mapping
    #mapping_kode = MappingDataObat.find_by_kode_rs(self.kode_obat)
    return MappingDataObat.exists?(:kode => self.kode_obat)
  end

  before_save :set_mapping, :clear_alasan
  def set_mapping
    total_tarif = 0
    #status_mapping = false
    mapping_data_obat = MappingDataObat.find_by_kode_rs(self.kode_obat_rs)
    if mapping_data_obat.nil?
      self.satuan_tarif_ejkbm = 0
      self.sub_total_tarif_ejkbm = 0
      self.flag = 2
    else
      obat = Obat.find_by_kode(mapping_data_obat.kode_ejkbm)
      tarif_satuan = obat.het_satuan
      self.satuan_tarif_ejkbm = tarif_satuan
      self.kode_obat_ejkbm = obat.kode
      self.flag = 1
      self.status_verifikasi_sistem = 1

      total_tarif = tarif_satuan * self.jumlah_obat_rs rescue 0
      self.sub_total_tarif_ejkbm = total_tarif
      
      status_mapping = true
    end
    #return status_mapping
  end

  def clear_alasan
    if self.status_verifikasi_verifikator == 1
      self.komentar = ''
      self.kode_alasan_verifikasi = nil
    end
  end


end
