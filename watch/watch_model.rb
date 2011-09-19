#! /usr/bin/ruby
require "observer"

#the Model class count clock ticks
class WatchModel
	include Observable

	def initialize
		@running = false
		@time = 0
		@last = 0.0

		Thread.start do
			loop do
				
				sleep 0.01
				if @running
					now = Time.now.to_f
					@time += (now - @last)
					
					changed
					notify_observers(@time)
				end
			end
		end
	end

	def start_stop
		@last = Time.now.to_f
		@running = ! @running
	end

	def time
		@time
	end

	def running
		@running
	end
end
