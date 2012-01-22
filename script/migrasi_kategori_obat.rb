require 'rubygems'
require 'csv'

class MigrasiKategoriObat
  def migrasi
    file = DIR_IN+"kategori_obat.csv"
    #path = DIR_IN+"Mapping/"
   # file = path+"kategori_obat.csv"
    CSV.foreach(file, :col_sep =>';', :row_sep =>:auto, :headers => true) do |col|


      #---------Penyimpanan ke tabel kategori obat---------
      col_kategori_obat = KategoriObat.new(
          :kode => col[0], :nama => col[1], :iduser => 1
      )
      col_kategori_obat.save
      puts "data berhasil di save di tabel kategori obat"
    end

  end
end

test = MigrasiKategoriObat.new
puts "-----------BEGIN------------"
test.migrasi
puts "------------END-------------"