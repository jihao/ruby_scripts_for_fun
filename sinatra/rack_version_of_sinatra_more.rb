#!/usr/bin/env ruby
module MySinatra

  class Base
    def self.prototype
      @prototype ||= new
    end
     
    def self.call(env)
      prototype.call(env)
    end

    def call(env)
      obj = dup
      puts obj
      obj.call!(env)
    end
    def call!(env)
      headers={'Content-Type'=>'text/html'}
      if env['PATH_INFO']=='/'
        status,body = 200,'hi'
      else
        status,body = 404,"Sinatra doesn't know this ditty "
      end
      headers['Content-Length'] = body.length.to_s
      [status,headers,[body]]
    end
  end

  class Application < Base
  end
end

require 'thin'
Thin::Server.start MySinatra::Application, 4567