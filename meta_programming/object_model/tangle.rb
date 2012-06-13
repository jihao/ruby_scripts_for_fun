#!/usr/bin/env ruby
module Printable
  def print
    puts "print in Printable"
  end
  def prapare_cover
  end
end
module Document
  def print_to_screen
    prepare_cover
    format_for_screen
    print
  end
  def prepare_cover
  end
  def format_for_screen
  end
  def print
    puts "pring in Document"
  end
end

class Book
  include Document
  include Printable
end

b = Book.new
b.print_to_screen
puts Book.ancestors.join(',')
puts ""
Book.ancestors.each do |x| 
 puts "#{x}.print (class method)" if x.methods().include? :print
 puts "#{x}#print (instance method)" if x.instance_methods().include? :print
end
  