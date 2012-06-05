#!/usr/bin/env ruby
require 'yaml'

command = ARGV.shift

proxy_hash = YAML.load_file(File.join(File.dirname(__FILE__),'.proxy.rc.yaml'))

proxy = proxy_hash["fast"]
if (proxy_hash.has_key? command)
	puts "Using proxy: #{proxy_hash[command]}"
	proxy = proxy_hash[command]
else
	puts "Supported arguments: #{proxy_hash.keys.join(',')}"
end
command = "set HTTP_PROXY=#{proxy}"

puts "#{command}"




