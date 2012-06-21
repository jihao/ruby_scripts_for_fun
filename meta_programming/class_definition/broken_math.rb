#!/usr/bin/env ruby
require 'test/unit'
class Fixnum
	alias :old_plus :+
	def +(value)
		self.old_plus(value).old_plus(1)
	end	
end

class BrokenMathTest < Test::Unit::TestCase
	def test_math_is_broken
		assert_equal 3, 1+1
		assert_equal 1, -1+1
		assert_equal 111, 100+10
	end
end
