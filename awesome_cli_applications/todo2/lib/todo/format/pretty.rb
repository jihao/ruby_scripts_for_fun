require 'rainbow'
module Todo
	module Format
		class Pretty
			def before; end
			def after; end
			def format(index,todo)
				color = :default
				if todo.completed?
					color = :green
				end
				
				puts sprintf("%3d,%3d - %s\n",index+1,todo.priority,todo.name.bright).color(color)
				puts sprintf("     %-10s %s","Created:",todo.created.strftime('%Y-%m-%d %H:%M:%S')).color(color)
				if todo.completed?
					puts sprintf("     %-10s %s\n","Completed:",todo.completed.strftime('%Y-%m-%d %H:%M:%S')).color(color)
				else
					printf("\n")
				end

				#printf("%3d,%3d - %s\n",index+1,todo.priority,todo.name.bright)
				#printf("     %-10s %s\n","Created:",todo.created.strftime('%Y-%m-%d %H:%M:%S'))
				#if todo.completed?
				#	printf("     %-10s %s\n\n","Completed:",todo.completed.strftime('%Y-%m-%d %H:%M:%S'))
				#else
				#	printf("\n")
				#end
			end
		end
	end
end