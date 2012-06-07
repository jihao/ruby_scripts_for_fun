require 'rainbow'
module Todo
	module Format
		class CSV
			def format(index,todo)
				complete_flag = todo.completed ? "DONE" : "INCOMPLETE"
				printf("%d,%s,%s,%s,%s\n",index+1, todo.priority, todo.name, complete_flag, todo.created.strftime('%Y-%m-%d %H:%M:%S'))
			end
		end
	end
end