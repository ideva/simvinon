require 'rubygems'
require 'csv'

class MigrasiPemeriksaan
  def migrasi
   # path = DIR_IN+"Mapping/"
   # file = path+"pemeriksaan.csv"
     file = DIR_IN+"pemeriksaan.csv"
    CSV.foreach(file, :col_sep =>';', :row_sep =>:auto, :headers => true) do |col|


      #---------Penyimpanan ke tabel obat---------
      col_pemeriksaan = Pemeriksaan.new(
          :kode => col[0], :nama => col[1],
          :tarif => col[2], :flag => col[3],
          :jenis_pelayanan => col[4], :iduser => 1
      )
      col_pemeriksaan.save
      
    end
    puts "data berhasil di save di tabel pemeriksaan"
  end
end

test = MigrasiPemeriksaan.new
puts "-----------BEGIN------------"
test.migrasi
puts "------------END-------------"