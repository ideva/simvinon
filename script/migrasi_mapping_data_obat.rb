require 'rubygems'
require 'csv'

class MigrasiMappingDataObat
  def migrasi
    path = DIR_IN+"Mapping/"
    file = path+"mapping_data_obat.csv"
    CSV.foreach(file, :col_sep =>';', :row_sep =>:auto, :headers => true) do |col|


      #---------Penyimpanan ke tabel mapping_data_obat---------
      col_mapping_data_obat = MappingDataObat.new(
          :kode_rs => col[0], :kode_ejkbm => col[2], :iduser => 1
      )
      col_mapping_data_obat.save
      puts "data berhasil di save di tabel mapping_data_obat"
    end

  end
end

test = MigrasiMappingDataObat.new
puts "-----------BEGIN------------"
test.migrasi
puts "------------END-------------"