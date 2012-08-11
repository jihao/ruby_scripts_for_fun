#!/usr/bin/env ruby
require "sinatra/base"

class MySinatraApp < Sinatra::Base 
	before do 
  		content_type :txt
	end
end

MySinatraApp.get('/') do
	'Hello world'
end

#MySinatraApp.run!