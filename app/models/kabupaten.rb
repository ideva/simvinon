class Kabupaten < ActiveRecord::Base
  def kode_nama
    "#{kode}, #{nama}"
  end
end
