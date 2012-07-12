#!/usr/bin/env ruby -wKU

require 'optparse'
# http://www.ruby-doc.org/stdlib-1.9.3/libdoc/optparse/rdoc/index.html
require 'English'
require 'open3'
require 'yaml'

options = {}

option_parser = OptionParser.new do |opts| 
  executable_name = File.basename $PROGRAM_NAME
  #opts.summary_indent = "\n  "
  opts.banner = "  #{executable_name} - Translate, squeeze, and/or delete characters from standard input, writing to standard output.

  Usage: #{executable_name} [OPTION]... SET1 [SET2]
  "
  
  opts.on("-c","-C","--complement",'use the complement of SET1') do
    options[:complement] = true
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
  opts.on("-h", "--help", "Show this message") do
    puts opts
    exit
  end

  # Another typical switch to print the version.
  opts.on("--version", "Show version") do
    puts OptionParser::Version.join('.')
    exit
  end

 
  opts.separator "
SETs are specified as strings of characters. Most represent themselves.
Interpreted sequences are:

  \\NNN character with octal value NNN (1 to 3 octal digits)
  \\\ backslash
  \\a audible BEL
  \\b backspace
  \\f form feed
  \\n new line
  \\r return
  \\t horizontal tab
  \\v vertical tab
  CHAR1-CHAR2 all characters from CHAR1 to CHAR2 in ascending order
#  [CHAR*] in SET2, copies of CHAR until length of SET1
#  [CHAR*REPEAT] REPEAT copies of CHAR, REPEAT octal if starting with 0
  [:alnum:] all letters and digits
  [:alpha:] all letters
  [:blank:] all horizontal whitespace
  [:cntrl:] all control characters
  [:digit:] all digits
  [:graph:] all printable characters, not including space
  [:lower:] all lower case letters
  [:print:] all printable characters, including space
  [:punct:] all punctuation characters
  [:space:] all horizontal or vertical whitespace
  [:upper:] all upper case letters
  [:xdigit:] all hexadecimal digits
  [=CHAR=] all characters which are equivalent to CHAR

Translation occurs if -d is not given and both SET1 and SET2 appear.
-t may be used only when translating.  SET2 is extended to length of
SET1 by repeating its last character as necessary.  Excess characters
of SET2 are ignored.  Only [:lower:] and [:upper:] are guaranteed to
expand in ascending order; used in SET2 while translating, they may
only be used in pairs to specify case conversion.  -s uses SET1 if not
translating nor deleting; else squeezing uses SET2 and occurs after
translation or deletion.

"
  
end

exit_status = 0
begin
  option_parser.parse!
  if ARGV.empty?
   puts "error: #{File.basename $PROGRAM_NAME}: missing operand"
   puts "Try `tr --help` for more information"
   #puts option_parser.help
   exit_status |= 0b0010
  else
   SET1 = ARGV[0]
   SET2 = ARGV[1]
  end
rescue OptionParser::InvalidArgument,OptionParser::InvalidOption => ex
  puts ex.message
  puts "Try `tr --help` for more information"
  exit_status |= 0b0001
end
exit exit_status unless exit_status == 0

puts options.inspect
puts SET1
puts SET2

while(str=STDIN.gets)
	puts str
end