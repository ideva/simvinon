class UserMailer < ActionMailer::Base

  def signup_notification(user)
    @user = user
    @subject  = 'Please activate your new account'
    @url  = "http://#{SITE}/activate/#{user.activation_code}"
    to = user.email
    setup_email(to, @subject)
  end
  
  def activation(user)
    @user = user
    @subject   = 'Your account has been activated!'
    @url  = "http://#{SITE}/"
    to = user.email
    setup_email(to, @subject)
  end

  def new_user_notification(user)
    @user = user
    setup_email_to_admin
    @subject   = "New user on #{SITE}"

    @body[:url]  = "User name : #{user.format_name}"

  end

  def reset_notification(user)
    @subject    += 'Link to reset your password'
    @body[:url]  = "http://#{SITE}/reset/#{user.reset_code}"
    to = user.email
    setup_email(to, @subject)
  end

  def comment_email(user, to, comment, url_comment, title)
    @user = user
    @comment = comment
    @url_comment = url_comment
    @title = title
    subject = "#{user.full_name} commented on #{title}"
    setup_email(to, subject)
  end

  def respon_email(user, to, respon, url, title)
    @user = user
    @respon = respon
    @url = url
    @title = title
    subject = "#{user.full_name rescue user} #{respon} #{title}"
    setup_email(to, subject)

  end

  def article_email(d_blog, email, msg, tags, user)
    @d_blog = d_blog
    @user = user
    @array_tag = tags
    @msg = msg
    subject = "[#{user.full_name rescue user}]#{d_blog.title}"
    to = email
    setup_email(to, subject)

  end

  def stuff_email(d_stuff, email, msg, tags, user)
    @d_stuff = d_stuff
    @user = user
    @array_tag = tags
    @msg = msg
    subject = "[#{user.full_name rescue user}]#{d_stuff.name}"
    to = email
    setup_email(to, subject)
  end

  def pm_email(email, msg, user)
    @user = user
    @msg = msg
    subject = "#{user.full_name rescue user} sent you a message"
    to = email
    setup_email(to, subject)
  end

  def cool_status_email(email, msg, user, d_cool_status)
    @user = user
    @msg = msg
    @d_cool_status = d_cool_status

    subject = "#{user.full_name rescue user} needs your support on Cool Status Competition"
    to = email
    setup_email(to, subject)
  end
  
  protected

  def setup_email(to, subject)
       mail( 
          :to => to,
          :from  => "Megenep<noreply@megenep.com>",
          :subject => subject,
          :headers => "Reply-to noreply@megenep.com" )do |format|
        format.html
      end
    end

    def setup_email_to_admin
      mail(
          :to => "#{ADMINEMAIL}",
          :from  => "Megenep<noreply@megenep.com>",
          :subject => "[#{SITE}] ",
          :headers => "Reply-to noreply@megenep.com" )do |format|
        format.html
      end

    end


  def setup_email_blast(to, replay_to, subject)
    if replay_to == ''
      replay_to = "noreplay@#{SITE}"
    end
    mail( :to => to,
          :from  => "#{FROMEMAIL}",
          :subject => subject,
          :headers => "Reply-to #{replay_to}",
          :content_type => "text/html" )do |format|
      format.html
    end
  end

end
