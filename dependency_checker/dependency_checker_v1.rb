#!/usr/bin/env ruby
# encoding: utf-8
# 
# this tiny tool helps you to check components dependencies
# author: haojii
# version: 0.0.1
# 
# find all component.nfo files
# read dependency information from one component

require 'find'  

Dependency_map={}
Nested_dependency_array=[]

# assum this will run from repository_dir like /personal/uid/repo
repository_dir_name = Dir.pwd

Dir.entries("#{repository_dir_name}/sog/").each { |component_name|
	Find.find("#{repository_dir_name}/sog/#{component_name}/component.nfo") do |f|  
		dependency_array = []
		if File.exist? f
			File.open(f) { |ff|
				while line = ff.gets
					#Depend:  SOG, ImsSRD, 3.0, 0
					match = line.match("(#)?Depend:\s*(SOG),\s*([a-zA-Z]+),\s*([0-9]+.*[0-9]),.*")
					#                    1             2        3              4
					if (match)
						if(match[1].nil?)
							name = match[3]
							version = match[4]
							#puts "#{name}#{version}"
							dependency_array.push "#{name}#{version}"
						else
							#puts "!!! #{line}"
						end
					end
				end
			}
		end
		Dependency_map[component_name] = dependency_array
	end
}

def build_depend_info(component_name)
	if ( component_name.match("(SystemMgmt|General)").nil?)
		#puts " " + component_name
		Nested_dependency_array.push component_name
	end
	
	dependency_array = Dependency_map[component_name]
	
	if !dependency_array.nil?
		dependency_array.each { |name|
			build_depend_info (name)
		}
	end
end

#build_depend_info ("ImsBWASSV17SP3")
build_depend_info ("#{ARGV[0]}")
puts "-------------------------"
puts Nested_dependency_array.uniq
