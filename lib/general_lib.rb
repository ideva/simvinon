def loop_and_check(string, split, match)
    strings = string.split("#{split}")
    strings.each do |x|
      unless x == ""
        if x.to_s.strip.downcase == match.to_s.strip.downcase
          return true
          break
        end
      end
    end
    return false
end

def code_generator(param='', length = 5)
  kode = rand(36**length).to_s(36).upcase
  if param == ""
  else
    kode = param + kode[1..length]
  end
  return kode
end

def image_code(model)
  #model_name = controller_name.classify
  code = code_generator('', 5) #code_generator(param, length)
  if model.find_by_code(code).nil?
    return code
  else
    generate_code
  end
end

def pagination(params_id, action_param)
    unless (session[:array_id].nil? rescue true) || (session[:array_id].empty? rescue true)
      index = -1
      session[:array_id].each do |id|
        index +=1
        if id == params_id.to_i
          break
        end
      end

      if session[:array_id].length - 1 == 0
        @prev_id = session[:array_id][index]
        session[:url_back] = "/#{self.controller_name}/searching_form/#{action_param}"
      else
        @prev_id = session[:array_id][index-1]
        session[:url_back] = "/#{self.controller_name}/searching/#{action_param}"
      end

      if session[:array_id].length - 1 == index
        @next_id = session[:array_id][index]
      else
        @next_id = session[:array_id][index+1]
      end
    else
      session[:url_back] = "/#{self.controller_name}/searching_form/#{action_param}"
      @prev_id = params_id
      @next_id = params_id
    end
  end

def format_time(t)

    return "" unless t
    new_t = t.in_time_zone
    now = DateTime.now.in_time_zone

    second_range = (Time.now.in_time_zone - new_t.to_time)
    hour_range = (second_range / 3600).to_i
    minute_range = (second_range / 60).to_i
    if new_t.to_date == now.to_date
      if minute_range > 60
        return "#{hour_range.to_i} hours ago"
      else
        if second_range < 60
          return "#{second_range.to_i} seconds ago"
        end
        return "#{minute_range.to_i} minutes ago"
      end
      return "Today"
    else
      range = now.to_date - new_t.to_date
      if range <= 0
        return "Today"
      elsif range == 1
        return "Yesterday"
      elsif range == 2
        return "2 days ago"
      elsif range > 2 && range < 7
        return "#{range} days ago"
      elsif range == 7
        return "a week ago"
      elsif range > 7 && range < 14
        return "#{range} days ago"
      elsif range == 14
        return "two weeks ago"
      elsif range > 14 && range < 21
        return "#{range} days ago"
      elsif range == 21
        return "three weeks ago"
      elsif range == 30
        return "a month ago"
      end
    end
    #return t.in_time_zone.strftime('%Y-%m-%d %H:%M:%S')
    return t.in_time_zone.strftime('%Y-%m-%d')

  end