#!/usr/bin/env ruby -wKU
module Kernel
  def using(resource)
    begin
      yield if block_given?
    ensure 
      resource.dispose
    end
  end
end
    