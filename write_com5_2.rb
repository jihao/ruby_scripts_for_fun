require 'rubygems'
require 'serialport'

# 0 is mapped to "COM1" on Windows, and 4 is COM5, 9600 is baud rate
# Arduino on serial port5   
sp = SerialPort.new(2, 9600)

def write(sp)
	puts "write H"
	sp.write "H"
	sleep(0.1)
	#rd = sp.read
	#puts rd[-2,2].to_i
	#puts rd[-2,2].to_i.chr
	#puts "[[[ %s ]]]" % rd   # hopefully "OK"
end

loop do
	write sp
	sleep 2
	puts "write L"
	sp.write "L"
	sleep 2
end