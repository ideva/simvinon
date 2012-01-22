  ActionMailer::Base.delivery_method = :smtp
  #ActionMailer::Base.delivery_method = :sendmail
  #ActionMailer::Base.sendmail_settings = {
    #:location       => '/usr/sbin/sendmail',
    #:arguments      => '-i -t -f support@yourapp.com'
  #}
  if Rails.env == 'production'
    ActionMailer::Base.smtp_settings = {
     :address => "mail.z4comp.com",
     :port => 587,
     :domain => "z4comp.com",
     :authentication => :login,
     :user_name => "info@z4comp.com",
     :password => "saritama",
     :enable_starttls_auto => false
 }
  else
    ActionMailer::Base.smtp_settings = {
     :address => "smtp.gmail.com",     
     :port => 587,#465 or 587
     :domain => "#{SITE}",
     :authentication => :plain,
     :user_name => "hisamuddin.riza@gmail.com",
     :password => "saritama"
     #:enable_starttls_auto => true
 }
  end
  
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.default_charset = 'utf-8'
#ActionMailer::Base.default_content_type = "text/html"
