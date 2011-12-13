#!/usr/bin/env ruby
# encoding: utf-8
#
# this tiny tool helps you to check components dependencies
# author: haojii
# version: 0.0.2
# 
require 'find'  

Dependency_map={}
Nested_dependency_array=[]

# assum this will run from repository_dir like /personal/<uid>/repo
Repository_dir_name = Dir.pwd

def print_usage
	puts "-----------Usage---------"
	puts "> ruby /path_to/dependency_checker_v2.rb <component_name>"
	puts ""
	puts " Note: please run this tool under your git repository root directory"
end

if ARGV.length != 1
	print_usage
	exit
else
	component_name = ARGV[0]
end

def build_depend_info(component_name)
	#puts "#{component_name}..."
	Find.find("#{Repository_dir_name}/sog/#{component_name}/component.nfo") do |f|  
		dependency_array = []
		#puts "#{f} ...."
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
		
		dependency_array.each { |item|
			if not Dependency_map.has_key? item
				build_depend_info item
			end
		}
	end
end

#build_depend_info ("ImsBWASSV17SP3")
build_depend_info (component_name)
puts "-------------------------"
puts Dependency_map.each_key.map.sort
puts "-------------------------"
#Dependency_map.each{|k,v|
	#puts "#{k} -> #{v.join(' , ')}"
#}
