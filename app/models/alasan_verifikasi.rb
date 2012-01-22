class AlasanVerifikasi < ActiveRecord::Base
  include UserInfo
  belongs_to :user, :foreign_key => "iduser"
  
  has_many :verifikasis

  validates_presence_of :kode, :alasan
  validates_uniqueness_of :kode, :case_sensitive => false, :message => "Kode telah digunakan"  
  def upper_case_kode
    self.kode.upcase!
  end

  before_save :asign_iduser
  before_destroy :check_cascade


  private
  def asign_iduser
    if current_user_id
      self.iduser = current_user_id
    end
  end

  def check_cascade
    unless Verifikasi.find_by_kode_alasan_verifikasi(self.kode).nil?
      return false
    end
    return true
  end
  
  
end
