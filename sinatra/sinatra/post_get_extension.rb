#!/usr/bin/env ruby
require 'sinatra/base'

module Sinatra
  module PostGet
    def post_get(route,&block)
      get(route, &block)
      post(route, &block)
    end
  end
  
  register PostGet
end
