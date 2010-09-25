# Rspec tests

require 'rubygems'
require 'uagent_rack'
require 'stringio'

describe 'UAgent::RackParser' do

  before(:all) do
    @env = {
      "SERVER_NAME" => "localhost",
      "HTTP_ACCEPT" => "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
      "HTTP_HOST" => "localhost:3001",
      "rack.session" => {},
      "HTTP_KEEP_ALIVE" => "115",
      "HTTP_USER_AGENT" => "Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.10) Gecko/20100915 Ubuntu/10.04 (lucid) Firefox/3.6.10",
      "REQUEST_PATH" => "/index",
      "rack.url_scheme"=>"http",
      "rack.request.cookie_hash" => {"rack.session"=>"cab867c36b7fc7385f5716cc5c793ac7"},
      "SERVER_PROTOCOL" => "HTTP/1.1",
      "HTTP_ACCEPT_LANGUAGE" => "en-us,en;q=0.5",
      "rack.errors" => IO.new(0),
      "REMOTE_ADDR" => "127.0.0.1",
      "PATH_INFO" => "/index",
      "SERVER_SOFTWARE" => "Mongrel 1.1.5",
      "rack.run_once" => false,
      "rack.version" => [1, 1],
      "SCRIPT_NAME" => "",
      "rack.request.cookie_string" => "rack.session=cab867c36b7fc7385f5716cc5c793ac7",
      "HTTP_COOKIE" => "rack.session=cab867c36b7fc7385f5716cc5c793ac7",
      "HTTP_VERSION" => "HTTP/1.1",
      "rack.multithread" => true,
      "REQUEST_URI" => "/index",
      "rack.multiprocess" => false,
      "SERVER_PORT" => "3001",
      "HTTP_ACCEPT_CHARSET" => "ISO-8859-1,utf-8;q=0.7,*;q=0.7",
      "REQUEST_METHOD" => "GET",
      "rack.session.options" => {
        :domain => nil,
        :expire_after => 2592000,
        :defer => false,
        :sidbits => 128,
        :secure => false,
        :key => "rack.session",
        :httponly => true,
        :renew => false,
        :id => "cab867c36b7fc7385f5716cc5c793ac7",
        :path => "/",
        :drop => false
      },
      "GATEWAY_INTERFACE" => "CGI/1.2",
      "HTTP_CONNECTION" => "keep-alive",
      "HTTP_ACCEPT_ENCODING" => "gzip,deflate",
      "QUERY_STRING" => "",
      "rack.input" => StringIO.new
    }
  end

  it 'get the user agent' do
    parser = UAgent::RackParser.new()
    env = @env.clone
    parser.call(env).should == :desktop
    env.merge!({
      "QUERY_STRING" => "user_agent=mobile",
      "REQUEST_URI" => "/index?user_agent=mobile",
    })
    parser.call(env).should == :mobile
    env = @env.clone
    parser.call(env).should == :mobile
  end

end
