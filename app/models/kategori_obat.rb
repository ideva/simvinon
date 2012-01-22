class KategoriObat < ActiveRecord::Base
  #set_primary_key :kode
  include UserInfo
  belongs_to :user, :foreign_key => "iduser"

  has_many :obats

  validates_presence_of :kode, :nama
  validates_uniqueness_of :kode, :case_sensitive => false, :message => "Kode telah digunakan"
  def upper_case_kode
    self.kode.upcase!
  end

  before_save :asign_iduser
  before_destroy :check_cascade # related with has_many

  private
  def asign_iduser
    if current_user_id
      self.iduser = current_user_id
    end
  end

  def check_cascade
    unless Obat.find_by_kode_kategori(self.kode).nil?
      return false
    end
    return true
  end

end
