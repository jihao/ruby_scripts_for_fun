require 'rubygems'
require 'rack'

class HelloWorld
  def call(env)
    [200, {"Content-Type" => "text/html"}, "Hello Rack!"]
  end
end

Rack::Handler::Mongrel.run HelloWorld.new, :Port => 9292

# gem install mongrel -V