class MappingDataTindakanMedi < ActiveRecord::Base
  include UserInfo
  belongs_to :user, :foreign_key => "iduser"
  belongs_to :tindakan_medi, :foreign_key => "kode_ejkbm", :class_name => "TindakanMedi", :primary_key => "kode"

  validates_presence_of :kode_rs, :kode_ejkbm

  before_save :asign_iduser
  private
  def asign_iduser
    if current_user_id
      self.iduser = current_user_id
    end
  end
end
