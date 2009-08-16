require 'twitter'
require File.join(File.dirname(__FILE__), '..', 'helpers', 'config_store')

class TwitterAccount
  attr_reader :friends

  def initialize
    config = ConfigStore.new("#{ENV['HOME']}/.twitter")
    httpauth = Twitter::HTTPAuth.new(config['email'], config['password'])
    @account = Twitter::Base.new(httpauth)
    @friends = @account.friends.map do |friend|
      friend.screen_name
    end
  end
end