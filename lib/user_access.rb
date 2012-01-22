#module UserAccess
  def activated?
      if logged_in? && current_user.state == "active"
        true
      else
        false
      end
    end

    def super_admin?
      if logged_in? && (current_user.super_admin rescue false)
        return true
      else
        return false
      end
    end

    def system_admin?
      if logged_in? && ( (current_user.iduser_level == 2) rescue false )
        return true
      else
        return false
      end
    end

    def owner?
      if logged_in? && (current_user.iduser_level == 3 rescue false)
        return true
      else
        return false
      end
    end

    def admin?
      if logged_in? && (current_user.iduser_level == 4 rescue false)
        return true
      else
        return false
      end
    end

    def activated_required
      activated? || activation_needed
    end

    def system_admin_required
      system_admin? || redirect_back_or_default("/")
    end

    def super_admin_required
      super_admin? || redirect_back_or_default("/")
    end

    def admin_required
      super_admin? || system_admin? || redirect_back_or_default("/")
    end

    def get_idparent
      idparent = nil
      if current_user.idparent.nil?
        idparent = current_user.id
      else
        idparent = current_user.idparent
      end
      return idparent
    end

    def check_user_concurrence(model)
      if logged_in?
        time_out = TIME_OUT
        counter = COUNTER_TO_TIME_OUT
        user_name = ''
        iduser_access = ''
        user_being_acces = nil
        model_name = controller_name.classify

        unless model.nil?
          lock_table = LockTable.find_by_id_to_lock_and_model(model.id, model_name)
          #if model.iduser_access.nil? || model.iduser_access == 0 || model.iduser_access == "" || model.session_id == session[:session_id] #model.iduser_access == current_user.id
          if lock_table.nil? || lock_table.iduser_access.nil? || lock_table.iduser_access == 0 || lock_table.iduser_access == "" || lock_table.session_id == session[:session_id]
            if lock_table.nil?
              lock_table = LockTable.new
            end
            lock_table.id_to_lock = model.id
            lock_table.model = model_name
            lock_table.iduser_access = current_user.id
            lock_table.session_id = session[:session_id]
            lock_table.counter = 1
            lock_table.save(perform_validation = false)
        
            model_name.constantize.connection.execute( 'SET AUTOCOMMIT=0' ) rescue false
            model.lock!
            @user_concurrence = true
            @idlock_table = lock_table.id
            @time_out_in_sec = time_out * 60
            status =  true
          else
            @user_concurrence = false
            if lock_table.updated_at.to_date <= Date.today
              #puts "== #{( (Time.now - lock_table.updated_at.to_time) / 60 ).to_i} >= #{time_out} =="
              if ( (Time.now - lock_table.updated_at.to_time) / 60 ).to_i >= time_out || lock_table.counter > counter # Timeout 10 minute
                lock_table.iduser_access = nil
                lock_table.session_id = nil
                lock_table.counter = 0
                lock_table.save(perform_validation = false)
                check_user_concurrence(model)
                status = true
              else
                user_being_acces = User.find(lock_table.iduser_access)
                status = false
              end
            end      
          end
        else
          status = false
        end
        return user_being_acces, status
      end
    end

    def return_user_concurrence
      if logged_in?
        time_out = TIME_OUT
        counter = COUNTER_TO_TIME_OUT
        @user_concurrence = false
        #lock_tables = LockTable.where(:iduser_access => current_user.id, :session_id => session[:session_id])
        lock_tables = LockTable.where("session_id IS NOT NULL")
        lock_tables.each do |lock_table|
          if ( (Time.now - lock_table.updated_at.to_time) ).to_i > time_out || lock_table.counter > counter
            lock_table.iduser_access = nil
            lock_table.session_id = nil
            lock_table.counter = 0
            lock_table.save(perform_validation = false)
          end
        end
      end
    end

    def user_concurrence_blocked(user_being_acces, is_redirect)
      user_name = user_being_acces.name rescue ''
      if user_name == ""
        flash[:error] = "Data sedang digunakan, cobalah beberapa saat lagi"
      else
        flash[:error] = "Data sedang digunakan oleh #{user_name}, cobalah beberapa saat lagi"
      end
      
      respond_to do |format|
        #if is_redirect
          #@show_bt_page = true
          format.html {redirect_to "/main/resctricted?error=#{CGI::escape( flash[:error])}" }
#        else
#          @show_bt_delete = false
#          @show_bt_save = false
#          @show_bt_add = false
#          @show_bt_cancel = false
#          #format.html {render "/main/resctricted" }
#          format.html {render :controller => :main, :action => :resctricted }
#        end
      end
    end
#end