#!/usr/bin/env ruby
# encoding: utf-8
#
puts "ARGV.length = #{ARGV.length}"
ARGV.each_with_index { |val,index|
	puts "ARGV[#{index}] = #{val}"
}