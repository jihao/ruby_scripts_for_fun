#!/usr/bin/env ruby
$: << File.dirname(File.realpath(__FILE__))
require 'using'
require "test/unit"

class TestUsing < Test::Unit::TestCase  
  class Resource
    def dispose
      @disposed = true
    end
    def disposed?
      @disposed
    end
  end
  
  def test_disposes_of_resources
    r = Resource.new
      using(r) {
        puts "do something within using block"
      }
    assert r.disposed?
  end
  def test_dispose_of_resource_in_case_of_exception
    r = Resource.new
    assert_raises(Exception) {
      using(r) {
        puts "do something within using block and raise exception"
        raise Exception
      }
    }
    assert r.disposed?
  end
end