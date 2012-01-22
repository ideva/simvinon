require 'rubygems'
require 'csv'

class MigrasiData
  def migrasi_kategori_tindakan_penunjang
    path = DIR_IN+"Mapping/"
    file = path+"kategori_tindakan_penunjang.csv"
    #file = path+"kategori_obat.csv"
    CSV.foreach(file, :col_sep =>';', :row_sep =>:auto, :headers => true) do |col|

      #---------Penyimpanan ke tabel kategori obat---------
      col_data = KategoriTindakanPenunjang.new(
          :kode => col[0], :nama => col[1], :iduser => 1
      )
      col_data.save
      puts "data berhasil di save di tabel kategori tindakan penunjang"
    end
  end

  def migrasi_kategori_tindakan_medis
    path = DIR_IN+"Mapping/"
    file = path+"kategori_tindakan_medis.csv"
   # file = path+"kategori_obat.csv"
    CSV.foreach(file, :col_sep =>';', :row_sep =>:auto, :headers => true) do |col|

      #---------Penyimpanan ke tabel kategori obat---------
      col_data = KategoriTindakanMedi.new(
          :kode => col[0], :nama => col[1], :iduser => 1
      )
      col_data.save
      puts "data berhasil di save di tabel kategori tindakan medis"
    end
  end

  def migrasi_tindakan_penunjang
    path = DIR_IN+"Mapping/"
    file = path+"tindakan_penunjang.csv"
   # file = path+"kategori_obat.csv"
    CSV.foreach(file, :col_sep =>';', :row_sep =>:auto, :headers => true) do |col|

      #---------Penyimpanan ke tabel kategori obat---------
      col_data = TindakanPenunjang.new(
          :kode => col[0],
          :kode_kategori_tindakan_penunjang => col[1],
          :nama => col[2],
          :tarif => col[3],
          :flag => col[4],
          :iduser => 1
      )
      col_data.save
      puts "data berhasil di save di tabel tindakan penunjang"
    end
  end

  def migrasi_tindakan_medis
    path = DIR_IN+"Mapping/"
    file = path+"tindakan_medis.csv"
    CSV.foreach(file, :col_sep =>';', :row_sep =>:auto, :headers => true) do |col|


      #---------Penyimpanan ke tabel kategori obat---------
      col_data = TindakanMedi.new(
          :kode => col[0],
          :kode_kategori_tindakan_medis => col[1],
          :nama => col[2],
          :tarif => col[3],
          :flag => col[4],
          :iduser => 1
      )
      col_data.save
      puts "data berhasil di save di tabel tindakan medis"
    end
  end

  def migrasi_kategori_obat
    path = DIR_IN+"Mapping/"
    file = path+"kategori_obat.csv"

    CSV.foreach(file, :col_sep =>';', :row_sep =>:auto, :headers => true) do |col|


      #---------Penyimpanan ke tabel kategori obat---------
      col_kategori_obat = KategoriObat.new(
          :kode => col[0], :nama => col[1], :iduser => 1
      )
      col_kategori_obat.save
      puts "data berhasil di save di tabel kategori obat"
    end

  end

  def migrasi_obat
    path = DIR_IN+"Mapping/"
    file = path+"obat.csv"
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

  def migrasi_pemeriksaan
    path = DIR_IN+"Mapping/"
    file = path+"pemeriksaan.csv"
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

test = MigrasiData.new
puts "-----------BEGIN------------"
#test.migrasi_kategori_tindakan_penunjang
#puts "----------------------------"
#test.migrasi_kategori_tindakan_medis
#puts "----------------------------"
#test.migrasi_tindakan_penunjang
#puts "----------------------------"
#test.migrasi_tindakan_medis
#puts "----------------------------"
#test.migrasi_kategori_obat
#puts "----------------------------"
#test.migrasi_obat
puts "----------------------------"
test.migrasi_pemeriksaan
puts "------------END-------------"