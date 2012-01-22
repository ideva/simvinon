class MainController < ApplicationController
  #before_filter :login_required, :except => []
  
  protect_from_forgery :except => [:index]
  #layout 'main', :only => ["index"]

  def about
    respond_to do |format|
        format.html{render :layout => "simple"}
    end
  end

  def index
    @message = "Welcome"
  end

  def resctricted
    respond_to do |format|
      if params[:error]
        flash[:error] = params[:error]
      elsif flash[:error].nil? || flash[:error] == ""
        flash[:error] = "Anda tidak mempunyai hak akses"
      end
      @show_bt_back = true
      session[:back] = request.fullpath

      format.html
    end
  end

  def page_not_found
    flash[:error] = "Data tidak ditemukan"
    @message = "Data tidak ditemukan"
  end

  def index_admin
     respond_to do |format|
        format.html {render :layout => "application"}
    end
  end

  def mail_blast
    respond_to do |format|
        format.html 
    end
  end

  def send_mail_blast
    array_to = params[:mail][:to].split(";")
    replay_to = params[:mail][:replay_to].strip rescue ''
    subject = params[:mail][:subject].strip rescue ''
    message = params[:mail][:message].strip rescue ''

    #UserMailer.send_email_blast(array_to, replay_to, subject, message).deliver

    respond_to do |format|
      if request.xhr?
        format.js {
          render :update do |page|
            page.alert('Email has been sent')
          end
        }
      else
        format.html { render :layout => "admin" }
      end
    end
  end

end
