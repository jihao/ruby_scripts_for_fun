#!/usr/bin/env ruby -wKU
require 'test/unit'

class C 
  def self.metaclass  # C.singleton_class
     class << self;self;end
  end
  def self.class_method
    puts "class_method defined in C.metaclass = #{self.metaclass}"
  end
  
  def metaclass # C.new.singleton_class
    class << self;self;end
  end
end

class MetaTest < Test::Unit::TestCase  
  def test_metaclass
    puts "C.metaclass = #{C.metaclass}; \r\nC.singleton_class = #{C.singleton_class}"
    puts "C.new.metaclass = #{C.new.metaclass};\r\nC.new.singleton_class = #{C.new.singleton_class}"
    puts 
  end
  def test_metaclass_superclass
    # puts "C.metaclass = #{C.metaclass}; \r\nC.singleton_class = #{C.singleton_class}"
    # puts "C.new.metaclass = #{C.new.metaclass};\r\nC.new.singleton_class = #{C.new.singleton_class}"
    puts "C.new.metaclass.superclass = #{C.new.metaclass.superclass};"
    puts 
  end
  
  def test_method_define
    C.class_method
    
    obj = C.new
    def obj.object_method
      puts "object_method in obj.metaclass = #{self.metaclass}"
    end
    obj.object_method
    puts
  end
  
  def test_method2
    puts "C.metaclass.instance_methods: "
    puts C.metaclass.instance_methods false
    
    obj = C.new
    def obj.object_method
      puts "object_method in obj.metaclass = #{self.metaclass}"
    end
    puts "obj(C.new).metaclass.instance_methods: "
    puts obj.metaclass.instance_methods false  
    puts
  end
  
  
end