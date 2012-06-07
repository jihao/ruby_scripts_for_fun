require 'terminal-table'
require 'rainbow'

module Todo
	module Format	
		class Table
			def before
				@@table = Terminal::Table.new :headings => %w(id priority name created completed)
				@@table.align_column(0,:right)
			end
			
			def format(index,todo)
				color = :default
				if todo.completed?
					color = :green
				end
				puts todo
				rows = []
				rows << (index+1)
				rows << todo.priority
				rows << todo.name.bright.color(color)
				rows << todo.created.strftime('%Y-%m-%d %H:%M:%S').color(color)
				if todo.completed?
					rows << todo.completed.strftime('%Y-%m-%d %H:%M:%S').color(color)
				else
					rows << " "
				end
				@@table << rows
			end
			def after
				puts @@table.to_s
			end
		end
	end
end