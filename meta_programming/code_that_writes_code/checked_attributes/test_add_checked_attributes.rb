#!/usr/bin/env ruby
require 'test/unit'

class Class
  def attr_checked(attribute,&validation)
  		define_method "#{attribute}=" do |val|
  		  if block_given?
  			  raise 'Invalid attribute' unless yield(val)
			  end
  			instance_variable_set("@#{attribute}",val)
  		end
  		define_method "#{attribute}" do
  			instance_variable_get("@#{attribute}")
  		end
  end
end

class Person 
  attr_checked :age do |v| 
    v > 19 
  end
end

class TestAddCheckedAttributes < Test::Unit::TestCase
	def setup
		# add_checked_attribute(Person, :age)
		# add_checked_attribute(Person, :age) do |arg|
    #       if arg.kind_of? Fixnum
    #         arg > 19 
    #   else
    #     false
    #        end
    # end
		@bob = Person.new
	end

	def test_accept_valid_values
		@bob.age = 20
		assert_equal 20, @bob.age
	end
	
	def test_accept_invalid_values
		assert_raises RuntimeError, 'Invalid attribute' do 
  		@bob.age = 16
  	end
	end
	
  # def test_refuses_nil_values
  #   assert_raises RuntimeError, 'Invalid attribute' do 
  #     @bob.age = nil
  #   end
  # end
  # 
  # def test_refuses_false_values
  #   assert_raises RuntimeError, 'Invalid attribute' do 
  #     @bob.age = false
  #   end
  # end
  
  
end
# def add_checked_attribute(clazz,attribute,&validation)
#   clazz.class_eval do
#     define_method "#{attribute}=" do |val|
#       raise 'Invalid attribute' unless validation.call(val)
#       instance_variable_set("@#{attribute}",val)
#     end
#     define_method "#{attribute}" do
#       instance_variable_get("@#{attribute}")
#     end
#   end
# end

# def add_checked_attribute(clazz,attribute)
#   clazz.class_eval do
#     define_method "#{attribute}=" do |val|
#       raise 'Invalid attribute' unless val
#       instance_variable_set("@#{attribute}",val)
#     end
#     define_method "#{attribute}" do
#       instance_variable_get("@#{attribute}")
#     end
#   end
# end

# def add_checked_attribute(clazz, attribute)
# 	eval  "
# 	class #{clazz}
# 		def #{attribute}= (val)
# 			raise 'Invalid attribute' unless val
# 			@#{attribute} = val
# 		end

# 		def #{attribute} ()
# 			@#{attribute}
# 		end
# 	end
# 	"
# end