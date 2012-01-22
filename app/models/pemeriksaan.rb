class Pemeriksaan < ActiveRecord::Base
  include UserInfo
  belongs_to :user, :foreign_key => "iduser"
  belongs_to :jenis_pelayanan, :foreign_key => "kode_jenis_pelayanan", :class_name => "JenisPelayanan", :primary_key => "kode"

  has_many :mapping_data_pemeriksaans, :dependent => :destroy, :foreign_key => "kode_pemeriksaan"

  validates_presence_of :kode, :nama
  validates_uniqueness_of :kode, :case_sensitive => false, :message => "Kode telah digunakan"
  def upper_case_kode
    self.kode.upcase!
  end

  validate :cek_flag
  before_save :asign_iduser, :assign_0
  before_destroy :check_cascade

  def status_flag
    if self.flag == 1
      return "Puskesmas"
    elsif self.flag == 2
      return "Rumah Sakit"
    end
  end

  def nama_pemeriksaan
    "#{self.kode}, #{self.nama}, Rp.#{self.tarif}"
  end

  def check_cascade
    unless MappingDataPemeriksaan.find_by_kode_pemeriksaan(self.kode).nil?
      return false
    end
    return true
  end
    

  private
  def asign_iduser
    if current_user_id
      self.iduser = current_user_id
    end
  end

  def assign_0
    if self.tarif.nil?
      self.tarif = 0
    end
  end

  def cek_flag
    if self.flag.nil?
      errors.add(:flag, " wajib diisi")
    end
  end
end
