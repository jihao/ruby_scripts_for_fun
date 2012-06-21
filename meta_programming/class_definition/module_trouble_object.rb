#!/usr/bin/env ruby
module MyModule
	def my_method
		'hello'
	end
end

obj = Object.new
class << obj
	include MyModule
end

puts obj.my_method
puts obj.singleton_methods