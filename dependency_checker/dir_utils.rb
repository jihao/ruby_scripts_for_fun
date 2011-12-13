#!/usr/bin/env ruby
# encoding: utf-8
#
# 运行ruby脚本的工作目录
puts Dir.pwd

# dir_utils.rb 所在的目录名称
puts File.dirname(__FILE__)
# puts File.absolute_path(__FILE__) #Ruby 1.9

# 文件名本身
puts File.basename(__FILE__)