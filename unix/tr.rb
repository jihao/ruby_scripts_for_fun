#!/usr/bin/env ruby -wKU

require 'optparse'
# http://www.ruby-doc.org/stdlib-1.9.3/libdoc/optparse/rdoc/index.html
require 'English'
require 'open3'
require 'yaml'

options = {}

option_parser = OptionParser.new do |opts| 
  executable_name = File.basename $PROGRAM_NAME
  opts.banner = "  #{executable_name} - translate or delete characters

  Usage: #{executable_name} [OPTION]... SET1 [SET2]
  "
  
  opts.on("-c","-C","--complement",'use the complement of SET1') do
    options[:complement] = true
  end
  #使用正则表达式校验参数
  opts.on("-u USER", "--user USER",/^(.+)\.(.+)$/,'Database username in first.last format') do |user|
    options[:user] = user
  end
  opts.on("-d","--delete",'delete characters in SET1, do not translate') do
    options[:delete] = true
  end
  opts.on("-s","--squeeze-repeats","replace each input sequence of a repeated character that is listed in SET1 with a single occurrence of that character") do
    options[:squeeze] = true
  end
  opts.on("-t","--truncate-set1","first truncate SET1 to length of SET2") do
    options[:truncate] = true
  end
  # No argument, shows at tail.  This will print an options summary.
      # Try it and see!
      opts.on_tail("-h", "--help", "Show this message") do
        puts opts
        exit
      end

      # Another typical switch to print the version.
      opts.on_tail("--version", "Show version") do
        puts OptionParser::Version.join('.')
        exit
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