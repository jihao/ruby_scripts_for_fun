#!/usr/bin/env ruby
require "sinatra"

before do
end

get %r{/(gr|sp)eedy} do
  pass if request.path =~ /\/speedy/
  "You got caught in the greedy route!"
end

get '/speedy' do
  "You must have passed to me!"
end