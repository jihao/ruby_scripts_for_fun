#!/usr/bin/env ruby
class CleanRoom
  def complex_calculation
    puts "complex_calculation"
    20
  end
  def do_something
    puts "do something"
  end
end

clean_room = CleanRoom.new
clean_room.instance_eval do
  if complex_calculation>10
    do_something
  end
end