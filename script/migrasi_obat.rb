require 'rubygems'
require 'csv'

class MigrasiObat
  def migrasi
    #path = DIR_IN+"Mapping/"
    #file = path+"obat.csv"
    file = DIR_IN+"obat.csv"
    CSV.foreach(file, :col_sep =>';', :row_sep =>:auto, :headers => true) do |col|


      #---------Penyimpanan ke tabel obat---------
      col_obat = Obat.new(
          :kode => col[0], :nama => col[1],
          :kode_kategori => col[2], :bentuk_kekuatan_kemasan => col[3],
          :jumlah => col[4], :satuan => col[5],
          :het_satuan => col[6], :het_pack => col[7],
          :iduser => 1
      )
      col_obat.save
      
    end
    puts "data berhasil di save di tabel obat"

  end
end

test = MigrasiObat.new
puts "-----------BEGIN------------"
test.migrasi
puts "------------END-------------"