#!/usr/bin/env ruby
module MyModule
	def self.my_class_method
		'hello'
	end
end

class MyClass
	# include MyModule # => undefined method `my_class_method' for MyClass:Class (NoMethodError)
	puts self
	class << self
		puts self
		include MyModule # not working on 1.9.3p194
	end
end

MyClass.my_class_method