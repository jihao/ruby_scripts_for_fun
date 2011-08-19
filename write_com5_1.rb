require 'rubygems'
require 'serialport'

def execute_cmd(chan, cmd)   
  print "Executing #{cmd} "  
  chan.write("#{cmd}\r")   
  begin  
    result = chan.readlines 
    result = "Command not support\n" if result.include?("ERROR\n")   
  rescue  
    result = "Writing serial port error\n"  
  end  
  print "Received: #{result}"
end  

def method  
	# Ardurino on serial port 5   
	File.open('com5:', 'r+') do |file|   
	  execute_cmd(file, "ABCD")   
	  sleep 2
		
	  1.upto(7) do |i|   
		execute_cmd(file, "HI_#{i}")   
		sleep 1
	  end  
	end  
end

loop do
	method
end