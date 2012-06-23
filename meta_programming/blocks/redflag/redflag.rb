#!/usr/bin/env ruby
def event(name, &block)
  #puts "ALERT: #{name}" if yield
  @events[name] = block
end

def setup(&block)
  @setups ||= []
  @setups << block
end

Dir.glob('*events.rb').each { |file|
  @events={}
  @setups=[]
  load file
  @events.each{ |name,block|
    env = Object.new
    
    @setups.each {|setup| 
      env.instance_eval &setup
    }
    puts "ALERT:#{name} "if env.instance_eval &block
  }
}