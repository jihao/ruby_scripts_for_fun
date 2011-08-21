require 'rubygems'
require 'gmail'
require 'serialport'

$username,$password = ARGV

def init_email_count
	gmail = Gmail.new($username, $password)
	$count = gmail.inbox.count(:unread)
	puts "unread email count: #{$count}"
	gmail.logout
end

def has_new_email?
	latest = get_latest_email_count
	if latest!=$count
		$count = latest
		puts "current email count: #{$count}"
		return true
	else
		return false
	end
end

def get_latest_email_count
	print '.'
	gmail = Gmail.new($username, $password)
	latest = gmail.inbox.count(:unread)
	gmail.logout
	gmail.disconnect
	return latest
end

def write_serialport chr
	puts "write to serial port [#{chr}]"
	$sp.write chr
	#rd = sp.read
	#puts "read from serial port [#{rd}]"
end


init_email_count
# 0 is mapped to "COM1" on Windows, and 2 is COM3, 9600 is baud rate
# Arduino on serial port2 (COM3)   
$sp = SerialPort.new(2, 9600)
loop do
	begin
		if has_new_email?
			write_serialport 'H'
			sleep 2
			write_serialport 'L'
		end
	rescue => error
		puts error.message
	end
	sleep 1
end

#not closed
#$sp.close