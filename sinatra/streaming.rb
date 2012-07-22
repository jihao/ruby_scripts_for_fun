#!/usr/bin/env ruby
require "sinatra"

before do
  content_type :txt
end
 
connections = []

get '/consume' do
  stream(:keep_open) do |out|
    # store connection for later on
    connections << out
    
    # remove connection when close properly
    out.callback{ connections.delete(out) }
    
    # remove connection when close due to an error
    out.errback do
      logger.warn 'we just lost a connection'
      connections.delete(out)
    end
  end
end

get '/broadcast/:message' do
  connections.each do |out|
    out << "#{Time.now} -> #{params[:message]}" << "\n"
  end
  
  "Sent #{params[:message]} to all clients\n"
end
  