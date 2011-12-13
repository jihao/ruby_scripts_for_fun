#! /usr/bin/ruby
class ExampleClass
	def do_something
		p "do_something"
	end
end

e = ExampleClass.new
e.do_something

class ExampleClass
	alias do_something_orig do_something
	undef do_something
	def do_something
		p "-> enter do_something"
		do_something_orig
		p "<- exit do_something"
	end
end

e.do_something