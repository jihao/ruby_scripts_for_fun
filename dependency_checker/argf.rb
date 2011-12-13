#!/usr/bin/env ruby
# encoding: utf-8
#
# run with > ruby argf.rb list_file
items = []
ARGF.each_with_index { |line,index|
	items << line
	puts "ARGF[#{index}] = #{line}"
}