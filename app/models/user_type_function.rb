class UserTypeFunction < ActiveRecord::Base
  belongs_to :user_type, :foreign_key => "iduser_type"
  belongs_to :function, :foreign_key => "idfunction"

  def self.function_list(iduser_type)
    string = ""
    objects = self.where(:iduser_type => iduser_type)
    unless objects.empty?
        objects.each do |object|
          string = object.idfunction.to_s + "," + string
        end
    end
    return string
  end

end
