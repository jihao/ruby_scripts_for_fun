#!/usr/bin/env ruby
require "sinatra"

get '/' do
  request.env.map {|e|
    e.to_s + "\n"
  }
end

get '/methods' do
  request.methods.map {|e|
    e.to_s + "\n"
  }
end

get '/cache' do
  # expires 3600, :public, :must_revalidate
  headers "Cache-Control" => "public, must-revalidate, max-age=3600",
          "Expires" => Time.at(Time.now.to_i + (60 * 60)).to_s 
  "This page rendered at #{Time.now}."
end