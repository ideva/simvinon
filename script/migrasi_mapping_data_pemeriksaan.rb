require 'rubygems'
require 'csv'

class MigrasiMappingDataPemeriksaan
  def migrasi
    path = DIR_IN+"Mapping/"
    file = path+"mapping_data_pemeriksaan.csv"
    CSV.foreach(file, :col_sep =>';', :row_sep =>:auto, :headers => true) do |col|


      #---------Penyimpanan ke tabel mapping_data_pemeriksaan---------
      col_mapping_data_pemeriksaan = MappingDataPemeriksaan.new(
          :kode_rs => col[0], :kode_ejkbm => col[2],
          :kode_pemeriksaan => col[4], :jenis_pelayanan => col[5],
          :iduser => 1
      )
      col_mapping_data_pemeriksaan.save
      puts "data berhasil di save di tabel mapping_data_pemeriksaan"
    end

  end
end

test = MigrasiMappingDataPemeriksaan.new
puts "-----------BEGIN------------"
test.migrasi
puts "------------END-------------"