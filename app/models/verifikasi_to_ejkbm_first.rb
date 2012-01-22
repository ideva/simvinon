class VerifikasiToEjkbmFirst < ActiveRecord::Base

  def self.sent_to_ejkbm_first_time
    #puts "------Checking Data to be sent to EJKBM first time--------"
    verifikasi_to_ejkbm_first = VerifikasiToEjkbmFirst.find_by_sent_to_ejkbm(false)
    if verifikasi_to_ejkbm_first.nil?
    else
      setting = Setting.find_by_name('URL_WS_EJKBM')
      #full_url = "#{setting.string_value}?#{URI.escape(parameter)}"
      #puts "===To EJKBM===#{full_url}======="
      require "net/http"
      require "uri"
      require "rexml/document"

      begin
        parameter = verifikasi_to_ejkbm_first.post_param
        
        tmp_param = Hash.new
        tmp_param2 = Hash.new
        #puts "#{parameter}"
        parameter = parameter[1..parameter.length-2]
        #puts "---------#{parameter}--------"
        tmp_1 = parameter.split(",")
        tmp_1.each do |tmp|
          tmp_2 = tmp.split("=>")
          #puts tmp_2[0].strip.to_s[1..tmp_2[0].strip.length-2]
          #puts "value ="+tmp_2[1].strip.to_s[1..tmp_2[1].strip.length-2]

          tmp_param = { tmp_2[0].strip.to_s[1..tmp_2[0].strip.length-2] => tmp_2[1].strip.to_s[1..tmp_2[1].strip.length-2] }
          tmp_param2.merge!(tmp_param)
        end
        
        param = {"flag_transaksi" => 1}
        tmp_param2.merge!(param)
        #puts "---------#{tmp_param2}--------"

        uri = URI(setting.string_value)
        result = Net::HTTP.post_form( uri, tmp_param2 )
        result = result.body
        #puts "--------------------------------------------"
        #puts result
        #puts "--------------------------------------------"

        x = REXML::Document.new result.to_s
        status =  x.root.elements['/boolean'].text
        if status.to_s == "true"
          verifikasi_to_ejkbm_first.sent_to_ejkbm = true
          verifikasi_to_ejkbm_first.save     
        end
        verifikasi_log = VerifikasiRequestLog.new
        verifikasi_log.request_out = "\n--URL-------\n"+uri.to_s+"\n--Parameter POST-------\n"+parameter.to_s+"\n--Result-------\n"+result
        verifikasi_log.save
      end

    end
  end

end
