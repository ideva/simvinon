require 'rubygems'
require 'rufus/scheduler'

scheduler = Rufus::Scheduler.start_new

#scheduler.in '20m' do
  #puts "order ristretto"
#end

#scheduler.at 'Thu Mar 26 07:31:43 +0900 2009' do
  #puts 'order pizza'
#end

#every day of the week at 22:00 (10pm)
#scheduler.cron '0 22 * * 1-5' do
  #puts 'activate security system'
#end

#scheduler.every '5m' do
  #puts 'check blood pressure'
#end

scheduler.every '1m' do
  VerifikasiToEjkbmFirst.sent_to_ejkbm_first_time
end

scheduler.cron '0 23 * * 1-5' do
 
end

