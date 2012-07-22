#!/usr/bin/env ruby
require "sinatra"

before do
  content_type :txt
end

get '/attachment' do
  attachment "attachment.txt"
  "Here is the content of what will be sent downstream, in an attachment called 'attachment.txt'"
end