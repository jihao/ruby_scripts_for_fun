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
  
  Note: the lines start with # was not implemented

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
#  CHAR1-CHAR2 all characters from CHAR1 to CHAR2 in ascending order
#  [CHAR*] in SET2, copies of CHAR until length of SET1
#  [CHAR*REPEAT] REPEAT copies of CHAR, REPEAT octal if starting with 0
#  [=CHAR=] all characters which are equivalent to CHAR
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
   set1 = ARGV[0]
   set2 = ARGV[1]
  end
rescue OptionParser::InvalidArgument,OptionParser::InvalidOption => ex
  puts ex.message
  puts "Try `tr --help` for more information"
  exit_status |= 0b0001
end
exit exit_status unless exit_status == 0

#puts "options.inspect=#{options.inspect}, SET1=#{set1}, SET2=#{set2}"

# handle options
if options[:truncate]
	set1 = set1[0,set2.length]
end

#The standard white-space characters are the following: space (' '), form feed ('\f'), new-line
#('\n'), carriage return ('\r'), horizontal tab ('\t'), and vertical tab ('\v').

# http://www.ruby-doc.org/core-1.9.3/Regexp.html

search = set1
replace = set2
if set1 =~ /^\[=/
	search = set1.match(/^\[=([0-9a-zA-Z]+)=\]/)[1]
	replace = set2
elsif set1 =~ /^\[:/
	search = "[#{set1}]"
	replace = set2[set2.length-1]
elsif set1 =~ /^\\/
	search = set1
	replace = set2
else #if not set1 =~ /^\[/
	search = "[#{set1}]"
	sub_hash={}
	i=0
	while i<set1.length && (!set2.nil?)
		val = set2[i]
		sub_hash[set1[i]]=( val ||= (set2[set2.length-1]))
		i=i+1
	end
	replace = sub_hash
end
# handle options
if options[:delete]
	replace = ''
end
# handle options
if options[:squeeze]
	replace = set2
end
if options[:complement]
	if search =~ /^\[/
		search = search[0]+'^'+search[1,search.length]
	end
end
replace||=''

while(str=STDIN.gets)	
	#puts "search= #{search}; replace= #{replace}"
	print str.gsub(Regexp.new("#{search}"), replace)
end
