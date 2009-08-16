require 'twitter'
require 'fusefs'
include FuseFS

class TwitterFuseFS < FuseFS::FuseDIR
  def initialize
    config = ConfigStore.new("#{ENV['HOME']}/.twitter")
    httpauth = Twitter::HTTPAuth.new(config['email'], config['password'])
    @twitter_user = Twitter::Base.new(httpauth)
  end

  def contents(path)
    
  end
end
