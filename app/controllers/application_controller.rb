class ApplicationController < ActionController::Base
  protect_from_forgery
  include AuthenticatedSystem
  include UserInfo
  before_filter :login_required
  
  rescue_from ActiveRecord::RecordNotFound do
    respond_to do |format|
#      if action_name == "edit"
#        pagination(params[:id], "manage")
#      elsif action_name == "show"
#        pagination(params[:id], "show")
#      end
      format.html {  render "main/page_not_found", :error => "Sorry, The page you looking is not found" }
      #format.html {redirect_to "/404"}
    end
  end

 rescue_from ActiveRecord::StaleObjectError do
     respond_to do |format|
        error = LOCK_ERROR_MSG
        format.html {redirect_to "/main/resctricted?error=#{CGI::escape(error)}" }
      end
 end

 rescue_from ActiveRecord::StatementInvalid do |exception|
     respond_to do |format|
       if exception.message =~ /Mysql::Error: Lock wait timeout exceeded;/
         error = LOCK_ERROR_MSG
       else
         error = "ActiveRecord::StatementInvalid"
         @message = exception.message
         session[:message] = exception.message
       end
        format.html {redirect_to "/main/resctricted?error=#{CGI::escape(error)}" }
      end
  end

  before_filter :set_initial_data, :set_title, :set_user, :set_form_id #, :update_function, :set_option_after_filter
  after_filter :set_to_nil, :set_auto_commit_to_1

  def send_to_ejkbm_first
    VerifikasiToEjkbmFirst.sent_to_ejkbm_first_time
  end

  def set_option_after_filter
    if action_name == "new" || action_name == "edit"
      @title_back = "Daftar data"
      session[:url_back] = "/#{controller_name}"
    end
  end

  def set_form_id
    if params[:id]
      @form_id = "#{action_name}_#{controller_name.to_s.singularize}_#{params[:id]}"
    else
      @form_id = "#{action_name}_#{controller_name.to_s.singularize}"
    end
  end

  def set_to_nil
    # Digunakan untuk menghapus pesan
    # Biasanya pesan ini didapatkan dari " rescue_from ActiveRecord::StatementInvalid "
    # Setelah pesan ditampilkan, maka pesan pada variable ini dihapus
    session[:message] = nil

    # is used at general_lib
    # session[:url_back] = nil
  end

  def clean_gallery
    Gallery.clean_gallery
  end

  def set_title
    @title = DEFAULT_TITLE
    @meta_description = DEFAULT_META_DESCRIPTION
    @meta_keywords = DEFAULT_META_KEYWORDS
    @canonical_url = "http://#{SITE}"
    flash[:extra_notice] = nil
    flash[:notice] = nil
    flash[:alert] = nil
    flash[:error] = nil
   
#    if self.action_name == "searching_form"
#      session[:array_id] = nil # is used at general_lib
#    end
  end

  # Sets the current user into a named Thread location so that it can be accessed
  # by models and observers
  def set_user
    UserInfo.current_user_id = session[:user_id]
  end

  def set_auto_commit_to_1
    if (@user_concurrence rescue false)#action_name == "edit"
    else
      return_user_concurrence rescue false
    end
  end

  def update_time_out
    idlock_table = params[:id]
    lock_table = LockTable.find(idlock_table)
    lock_table.counter = lock_table.counter + 1
    lock_table.save
    return_user_concurrence

    respond_to do |format|
      format.js do
        render :update do |page|
          if lock_table.counter > COUNTER_TO_TIME_OUT
            flash[:error] = TIME_OUT_MSG
            url_back = request.referer.split("?")
            url_back = url_back[0]
            session[:url_back] = url_back

            page.redirect_to "/main/resctricted?error=#{CGI::escape(flash[:error])}"
          else

          end
        end
      end
    end
  end

  def update_function
    controller_name = self.controller_name
    if controller_name == "application" || controller_name == "main" || controller_name == "sessions" ||
        (controller_name == "users" && (action_name == "forgot" || action_name == "form_change_password") ) ||
        action_name == "searching" || request.xhr? || request.post? || request.put?
    else
      action_name = self.action_name
      name = "#{self.controller_name.classify} - #{self.action_name}"

      funtion = Function.find_by_controller_name_and_action_name(controller_name, action_name)
      if funtion.nil?
        funtion = Function.new
        funtion.name = name
        funtion.controller_name = controller_name
        funtion.action_name = action_name

        funtion.save
    end
    end
  end


  def set_initial_data
    
  end

end
