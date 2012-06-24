#!/usr/bin/env ruby -wKU
class Object
  class << self # open the meta class
    alias :meta_class :singleton_class
  end
  alias :meta_class :singleton_class
end

class C
  def self.class_method
    'a class method'
  end
  def a_method
    'an instance method'
  end   
end

class D < C
  
end

obj = D.new
puts obj.a_method
puts D.meta_class # #<Class:D>
puts D.meta_class.superclass # #<Class:C>
puts D.superclass # C
puts D.superclass.meta_class # #<Class:C>

puts D.superclass.superclass # Object
puts D.superclass.superclass.meta_class # #<Class:Object> 
puts D.superclass.superclass.superclass # BaseObject
puts D.superclass.superclass.superclass.meta_class # #<Class:BaseObject>

puts obj.meta_class   # #<Class:#<D:0x007fe692835448>>
puts obj.meta_class.superclass # D


#                     BaseObject ---[m]c--->  #<Class:BaseObject> 
#                          ^                   ^
#                          |                   |
#                     super class         super class
#                          |                   |
#                          |                   |
#                      Object ---[m]c--->  #<Class:Object> 
#                          ^                   ^
#                          |                   |
#                     super class         super class
#                          |                   |
#                          |                   |
#                          C ---[m]c--->  #<Class:C> 
#                          ^                   ^
#                          |                   |
#                     super class         super class
#                          |                   |
#                          |                   |
#                          D ---[m]c--->  #<Class:D> 
#                          ^
#                          |
#                     super class
#                          |
#                          |
#  obj ---[m]c--->  #<Class:#<D>> 