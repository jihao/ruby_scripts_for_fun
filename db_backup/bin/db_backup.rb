#!/usr/bin/env ruby

require 'optparse'
# http://www.ruby-doc.org/stdlib-1.9.3/libdoc/optparse/rdoc/index.html

options = {}
option_parser = OptionParser.new do |opts| 
  opts.on("-i","--iteration") do
    options[:iteration] = true
  end
  #使用正则表达式校验参数
  opts.on("-u USER", /^(.+)\.(.+)$/) do |user|
    options[:user] = user
  end
  opts.on("-p PASSWORD") do |password|
    options[:password] = password
  end
  opts.on("-t","--[no-]test") do |val|
    options[:test] = val
  end
  
  servers = {:dev => '127.0.0.1',
             :qa => 'qa007.example.com',
             :prod => 'www.example.com'}
  opts.on("-s SERVER", "--server SERVER", servers) do |address|
    # 仅支持上面的三个key,并用value作为address的值
    options[:server] = address
  end
end

option_parser.parse!
puts options.inspect