require 'rubygems'
require 'gmail'

username,password = ARGV

gmail = Gmail.new(username, password)
count = gmail.inbox.count(:unread)
puts "count #{count}"

def has_new_email?
	get_latest_email_count!=count
end

def get_latest_email_count
	gmail.inbox.count(:unread)
end

def write_serialport chr
	puts "write to serial port #{chr}"
end

loop do
	if has_new_email?
		write_serialport 'H'
		sleep 60
		count = get_latest_email_count
		write_serialport 'L'
	end
	puts '.'
	sleep 2
end

gmail.logout