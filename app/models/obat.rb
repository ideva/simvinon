class Obat < ActiveRecord::Base
  include UserInfo
  belongs_to :user, :foreign_key => "iduser"
  belongs_to :kategori_obat, :foreign_key => "kode_kategori", :class_name => "KategoriObat", :primary_key => "kode"
  has_many :verifikasi_obats

  has_many :mapping_data_obats, :dependent => :destroy, :foreign_key => "kode_ejkbm"
  
  validates_presence_of :kode, :nama
  validates_uniqueness_of :kode, :case_sensitive => false, :message => "Kode telah digunakan"
  def upper_case_kode
    self.kode.upcase!
  end

  before_save :asign_iduser, :assign_0

  def nama_obat
    "#{self.kode}, #{self.nama},Rp.#{self.het_pack}"
  end

  private
  def asign_iduser
    if current_user_id
      self.iduser = current_user_id
    end
  end

  def assign_0
    if self.jumlah.nil?
      self.jumlah = 0
    end
    
    if self.het_pack.nil?
      self.het_pack = 0
    end
    
    if self.het_satuan.nil?
      self.het_satuan = 0
    end
  end

end
