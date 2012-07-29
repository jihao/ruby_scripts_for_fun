#!/usr/bin/env ruby
require "sinatra/base"

class MyApp < Sinatra::Base 
end

MyApp.get '/' do 
	"Hello world"
end

MyApp.run! if  File.expand_path($0) == File.expand_path(__FILE__) 