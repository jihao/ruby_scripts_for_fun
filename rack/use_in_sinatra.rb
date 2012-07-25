#!/usr/bin/env ruby
require "sinatra"
require "rack"

# A handy middleware that ships with rack
# and sets the X-Runtime header
use Rack::Runtime
get '/' do
	'Hello world'
end