require 'rubygems'
require 'csv'

class MappingData
  def migrasi
    begin
    val = false
    path = DIR_IN+"Mapping/"
    Dir.glob(path+'*.CSV'){|file|
      if File.exist?(file) or File.symlink?(file)
          val = true
          file_name = File.basename(file)


          if (val == true) then
            csv_text = path+file_name
            CSV.foreach(csv_text, :col_sep =>';', :row_sep =>:auto, :headers => true) do |col|

              kode_rs = col[0]
              if kode_rs.nil?
                kode_rs = ""
              end

              kode_ejkbm = col[2]
              if kode_ejkbm.nil?
                kode_ejkbm = ""
              end

              (file_name == 'mapping_data_obat.csv')
              if (file_name == 'mapping_data_pemeriksaan.csv') then
                  map = MappingDataPemeriksaan.new
                  map.kode_tm_rs = kode_rs
                  map.kode_tm_ejkbm = kode_ejkbm
                  map.kode_pemeriksaan = col[4]
              else
                if (file_name == 'mapping_data_tindakan.csv') then
                  map = MappingDataTindakan.new
                elsif (file_name == 'mapping_data_pemeriksaan.csv')
                  map = MappingDataPemeriksaan.new

                elsif (file_name == 'mapping_data_penunjang.csv')
                      map = MappingDataPenunjang.new
                end

                map.kode_rs = kode_rs
                map.kode_ejkbm = kode_ejkbm
              end
              map.save

            end
          end
      end
    }
    end
  end
end

test = MigrasiData.new
puts "-------------BEGIN--------------"
test.migrasi
puts "--------------END---------------"