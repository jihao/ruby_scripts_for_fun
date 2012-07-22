#!/usr/bin/env ruby
require "sinatra"

configure do
  enable :sessions
end

before do
  # content_type :txt
end

get '/set' do
  response.set_cookie "foo","bar"
  "Cookie set. Would you like to <a href='/read'>read it</a>?"
end

get '/read' do
  "Cookie has a value of #{request.cookies['foo']}"
end

get '/delete' do
  response.delete_cookie "foo"
  "Cookie has been delete"
end