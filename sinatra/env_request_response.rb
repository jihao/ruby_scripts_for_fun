#!/usr/bin/env ruby
require "sinatra"
helpers do
  def assert(condition)
    fail "something is terriblt broken" unless condition
  end
end

get '/' do
  assert env['PATH_INFO'] == request.path_info
  final_result = response.finish
  assert Array === final_result
  assert final_result.length == 3
  assert final_result.first == 200
  
  content_type :txt
  puts final_result
  
  "everything is fine"
end