#! /usr/bin/ruby

require "watch_model"
require "watch_view"

#the View to show watch
class WatchController
	def initialize
		@model = WatchModel.new
		@view = WatchView.new(@model)
		system "stty cbreak -echo"
		begin
			@view.update(@model.time)
			loop do
				break if STDIN.getc == ?q
				@model.start_stop
			end
		ensure
			system "stty cooked echo"
		end
	end
end

WatchController.new
