#!/usr/bin/env ruby

output_file = "tmp.txt"
i = 100
while i > 0 
	sleep(1)
	i=i-1
end

# kill -2 pid 为啥没玩成功呢?

Signal.trap("SIGINT") do 
  put "trap SIGINT"
	FileUtils.rm output_file
	exit 1
end

