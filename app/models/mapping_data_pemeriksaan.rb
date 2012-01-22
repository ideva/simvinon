class MappingDataPemeriksaan < ActiveRecord::Base
  include UserInfo
  belongs_to :user, :foreign_key => "iduser"
  belongs_to :pemeriksaan, :foreign_key => "kode_pemeriksaan_ejkbm", :class_name => "Pemeriksaan", :primary_key => "kode"


  validates_presence_of :kode_pemeriksaan_rs, :kode_pemeriksaan_ejkbm

  before_save :asign_iduser
  private
  def asign_iduser
    if current_user_id
      self.iduser = current_user_id
    end
  end
end
