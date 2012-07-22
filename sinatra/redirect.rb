#!/usr/bin/env ruby
require "sinatra"

get '/redirect' do
  redirect 'http://www.google.com'
  # HTTP/1.1 302 Moved Temporarily
end

get '/redirect2' do
  redirect 'http://www.google.com', 301
  # HTTP/1.1 301 Moved Permanently
  
end