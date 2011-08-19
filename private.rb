class Parent
	def say
		puts "say in parent"
	end
	private :say
	
	def speak
		say
	end
end

class Child < Parent
	def say
		puts "say in child"
	end
end

c = Child.new
c.speak	#say in child