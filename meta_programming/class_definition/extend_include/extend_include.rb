#!/usr/bin/env ruby -wKU
module ExtendInclude
  module ClassMethods
    def class_method1
      puts "class_method1"
    end
  end
  
  module InstanceMethods
    def instance_method1
      puts "instance_method1"
    end
  end
  def instance_method1_in_module
     puts "instance_method1_in_module"
  end
  # def self.included(receiver)
  #   receiver.extend         ClassMethods
  #   receiver.send :include, InstanceMethods
  # end
end

class MyClass
  include ExtendInclude
end

obj = MyClass.new
obj.instance_method1_in_module
obj.instance_method1
MyClass.class_method1