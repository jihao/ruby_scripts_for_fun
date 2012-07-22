#!/usr/bin/env ruby
require "sinatra"

configure do
  mime_type :plain, 'text/plain'
end

before '/plain-text' do
  content_type :plain
end

get '/html' do
  '<h1>You should see HTML rendered</h1'
end

get '/plain-text' do
  '<h1>You should see plain text rendered</h1'
end
