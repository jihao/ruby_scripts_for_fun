#!/usr/bin/env ruby

lines=[]
ARGF.readlines.each {|line| lines << line.chomp}
puts lines.sort.join("\n")