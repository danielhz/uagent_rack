
require 'rubygems'
require 'uagent'
require 'rack'

module UAgent

  class RackParser < Parser

    def call(env)
      req = Rack::Request.new(env)
      unless req.params['user_agent'].nil?
        req.session[:user_agent] = req.params['user_agent'].to_sym
      end
      req.session[:user_agent] || super(env)
    end

  end

end
