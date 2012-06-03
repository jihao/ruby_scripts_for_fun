#!/usr/bin/env ruby
def read_file(io,lines)
  io.readlines.each {|line|
    lines << line.chomp
  }
end
lines=[]
if ARGV.empty?
  read_file(STDIN, lines)
else
  ARGV.each {|file| read_file(File.open(file),lines)}
end

puts lines.sort.join("\n")