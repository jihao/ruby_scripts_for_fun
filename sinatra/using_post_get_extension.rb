#!/usr/bin/env ruby
require 'sinatra'
require './sinatra/post_get_extension'

post_get '/' do
  "Hi #{params[:name]}"
end