#!/usr/bin/env ruby
require "sinatra"

get '/index' do
  @name = 'Random User'
  @users = ['Sally','Jerry','Rocko']
  erb :external_template  # template name must be a symbol
end