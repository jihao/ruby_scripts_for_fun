#!/usr/bin/env ruby

require 'optparse'
# http://www.ruby-doc.org/stdlib-1.9.3/libdoc/optparse/rdoc/index.html
require 'English'
require 'open3'

options = {}
option_parser = OptionParser.new do |opts| 
  executable_name = File.basename $PROGRAM_NAME
  opts.banner = "  Backup one or more MySQL databases
  Usgae: #{executable_name} [options] database_name
  "
  
  opts.on("-i","--iteration",'Indicate that this back up is an "iteration" backup') do
    options[:iteration] = true
  end
  #使用正则表达式校验参数
  opts.on("-u USER", "--user USER",/^(.+)\.(.+)$/,'Database username in first.last format') do |user|
    options[:user] = user
  end
  opts.on("-p PASSWORD",'Database password') do |password|
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

exit_status = 0
begin
  option_parser.parse!
  if ARGV.empty?
   puts "error: you must supply a database_name"
   puts
   puts option_parser.help
   exit_status |= 0b0010
  else
   database_name = ARGV[0]
  end
rescue OptionParser::InvalidArgument,OptionParser::InvalidOption => ex
  puts ex.message
  puts option_parser.help
  exit_status |= 0b0001
end
exit exit_status unless exit_status == 0

puts options.inspect

auth = ""
auth += "-u#{options[:user]} " if options[:user]
auth += "-p#{options[:password]} " if options[:password]
output_file = "#{database_name}.sql"

command = "mysqldump #{auth}#{database_name} >#{output_file}"
puts "Running '#{command}'"
stdout_str ,stderr_str, status = Open3.capture3(command)
unless status.success?
  STDERR.puts "There was a problem running '#{command}'"
  STDERR.puts stderr_str.gsub(/^mysqldump: /,'')
  exit 1
end