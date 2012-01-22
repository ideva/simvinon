class UserType < ActiveRecord::Base
  has_many :users
  has_many :user_type_functions

  after_create :generate_code

  private
  def generate_code
    kode = code_generator('', 5) #code_generator(param, length)
    if self.class.find_by_kode(kode).nil?
      self.kode = kode
      self.save
    else
      generate_code
    end
  end
  

end
