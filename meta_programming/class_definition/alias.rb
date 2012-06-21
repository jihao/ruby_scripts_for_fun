#!/usr/bin/env ruby
class MyClass
	def my_method
		'my_method'
	end

	alias :m :my_method
	undef :my_method
end

obj = MyClass.new
puts obj.m
puts obj.my_method

