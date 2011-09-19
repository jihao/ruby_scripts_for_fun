#! /usr/bin/ruby

#require "observer"

#the View to show watch
class WatchView
	def initialize(model)
		model.add_observer(self);
	end

	def update(time) 
		printf "\e[3D%02d:%02d",time.to_i,(time-time.to_i)*100
		STDOUT.flush
	end
end
