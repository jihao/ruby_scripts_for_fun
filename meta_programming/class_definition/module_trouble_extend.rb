#!/usr/bin/env ruby
module MyModule
	def my_method
		'hello'
	end
end

obj = Object.new
obj.extend MyModule

puts obj.my_method
puts obj.singleton_methods

class MyClass
	extend MyModule	
end

puts MyClass.my_method
puts MyClass.singleton_methods
