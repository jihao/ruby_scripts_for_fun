#!/usr/bin/env ruby -wKU
require "net/ssh/gateway"

msg = "welcome ^_^"

gateway = Net::SSH::Gateway.new('150.236.223.68','test',{:password=>'test'})

gateway.ssh("10.170.67.84", "root", {:password=>"root000"}) do |ssh|
    puts ssh.exec!("hostname")
    puts ssh.exec!("echo #{msg} > /etc/motd")
    puts ssh.exec!("cat /etc/motd") # => print welcome
end
gateway.ssh("10.170.67.84", "root", {:password=>"root000"}) do |ssh|
    puts ssh.exec!("hostname")
    puts ssh.exec!("cat /etc/motd") # => empty, why?
end
gateway.shutdown!