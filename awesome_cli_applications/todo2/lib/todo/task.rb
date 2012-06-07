module Todo
	class Todo
		 [:name,:priority,:created,:completed].each do |field|
			attr field
		 end
		 
		 def initialize(priority,name,created,completed)     
			  @name = name
			  @priority = priority
			  @created = DateTime.parse(created)
			  @completed =  (completed ? DateTime.parse(completed) : nil)
		 end
		 def to_s
		   "#{@priority},#{@name},#{@created.strftime('%Y-%m-%d %H:%M:%S')}".concat(@completed.nil? ? "" : ",#{@completed.strftime('%Y-%m-%d %H:%M:%S')}")
		 end
		 
		 def completed?
			!@completed.nil?
		 end
		 
		 def self.append_task_to_file(filename, priority, new_task)
		  File.open(filename,'a') do |file|
			  file.puts "#{priority},#{new_task},#{Time.now.strftime('%Y-%m-%d %H:%M:%S')}"
			  puts "Task added."
		  end
		end
		def self.complete_task(filename, task_number)
		  File.open(filename,'r') do |file|
			  counter = 1
			  File.open(filename+".tmp","w") do |tmp_file|  
				file.readlines.each do |line|
				  if (counter==task_number)
					tmp_file.puts("#{line.chomp},#{Time.now.strftime('%Y-%m-%d %H:%M:%S')}")
				  else
					tmp_file.puts("#{line.chomp}")
				  end
				  counter += 1;
				end
			  end
		  end
		  `mv #{filename}.tmp #{filename}`
		  puts "Task #{task_number} completed."
		end

		def self.read_todos(filename)
		   todos = []
		   File.open(filename,'r') do |file|
			 counter = 1
			 
			 file.readlines.each do |line|
			   priority,name,created,completed = line.chomp.split(/,/)
			   todo = Todo.new(priority,name,created,completed)
			   todos.push(todo)
				 counter +=1
			 end
		   end
		   return todos
		end

	end
end