#!/usr/bin/env ruby
require "sinatra/base"
class Blog < Sinatra::Base
	# File.expand_path generates an absolute path.
# It also takes a path as second argument. The
# generated path is treated as being relative
# to that path.
	set :root, File.expand_path('../../', __FILE__)
	get('/') {
		@message = 'worked' 
		markdown "# A Headline"
	}
end

Blog.run! if  File.expand_path($0) == File.expand_path(__FILE__) 