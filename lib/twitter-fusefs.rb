require 'twitter'
require 'fusefs'
require File.join(File.dirname(__FILE__), '..', 'helpers', 'config_store')

include FuseFS

class TwitterFuseFS < FuseFS::FuseDir
  def initialize
    config = ConfigStore.new("#{ENV['HOME']}/.twitter")
    httpauth = Twitter::HTTPAuth.new(config['email'], config['password'])
    @twitter_user = Twitter::Base.new(httpauth)
  end

  def contents(path)
    
  end
end
