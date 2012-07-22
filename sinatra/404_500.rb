#!/usr/bin/env ruby
require "sinatra"

not_found do
  "Whoops! You requested a route that wasn't avaliable"
end

configure do
  set :show_exceptions, false
end

get '/div_by_zero' do
  0/0
  "You won't see me."
end

error do
  "Y U NO WORK?"
end