require 'twitter'
require File.join(File.dirname(__FILE__), '..', 'helpers', 'config_store')

class TwitterAccount
  attr_reader :friends, :followers

  def initialize
    config = ConfigStore.new("#{ENV['HOME']}/.twitter")
    httpauth = Twitter::HTTPAuth.new(config['email'], config['password'])
    @account = Twitter::Base.new(httpauth)

    @friends = @account.friends.map do |friend|
      friend.screen_name
    end

    @followers = @account.followers.map do |follower|
      follower.screen_name
    end
  end

# wating for a better formating (see twitter gem bien)
  def friends_timeline
    texts = @account.friends_timeline.map {|t| "#{t.user.screen_name}> #{t.text}"}
    texts.join("\n")
  end
end
