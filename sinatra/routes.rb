#!/usr/bin/env ruby
require 'sinatra'

get '/' do
"Triggered via GET"
end
post '/' do
"Triggered via POST"
end
put '/' do
"Triggered via PUT" end
delete '/' do
"Triggered via DELETE"
end
patch '/' do
"Triggered via PATCH"
end
options '/' do
"Triggered via OPTIONS"
end

['/one','/two','/three'].each { |route|
  get route do
    "Triggered #{route} via GET" 
  end
  post route do
    "Triggered #{route} via POST"
  end
}
# 
get '/:name' do
"Hello, #{params[:name]}!"
end

post '/login' do
username = params[:username] 
password = params[:password]
"Welcome, #{username}!"
end

put '/users/:id' do
# let's assume we could retrieve a
  puts params[:id]
  
  puts  params[:first_name]
  puts  params[:last_name]
end

get '/*' do
  "You passed in #{params[:splat]}"
end