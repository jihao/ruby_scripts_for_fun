require "json_browser/version"
require 'rubygems'
require 'readline'
require 'optparse'

module JsonBrowser
  # Your code goes here...
  class Context
	attr_reader :here
	attr_reader :parent_context
	def initialize(here,parent_context)
		@here = here
		@parent_context = parent_context
	end
	
	def to_s
		if self.here.kind_of? Array
			indices = []
			self.here.each_index { |i| indices << i }
			indices.join(' ')
		elsif self.here.kind_of? Hash
			self.here.keys.join(' ')
		else
			self.here.to_s
		end
	end
	
	def cat(path)
		item_at(path)
	end
	
	def cd(path)
		if path=='..'
			self.parent_context
		else
			item = item_at(path)
			if item.nil?
				nil
			else
				Context.new(item,self)
			end
		end
	end
	
	private
	def item_at(path)
		if path=='..'
			self.parent_context.here
		elsif self.here.kind_of? Array
			self.here[path.to_i]
		elsif self.here.kind_of? Hash
			self.here[path]
		else
			nil
		end
	end
	
  end

end
