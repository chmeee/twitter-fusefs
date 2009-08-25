require 'twitter'
require File.join(File.dirname(__FILE__), '..', 'helpers', 'config_store')

class TwitterAccount
  attr_reader :friends, :followers, :twitter_id

  def initialize
    config = ConfigStore.new("#{ENV['HOME']}/.twitter")
    httpauth = Twitter::HTTPAuth.new(config['email'], config['password'], :ssl => true)
    @account = Twitter::Base.new(httpauth)

    @friends = @account.friends.map do |friend|
      friend.screen_name
    end

    @followers = @account.followers.map do |follower|
      follower.screen_name
    end

#    @twitter_id = @account.user_timeline.first[:id]
    @twitter_id = @account.user_timeline.first.id
  end

# wating for a better formating (see twitter gem bien)
# this methods are looking for some factoring
  def friends_timeline
    texts = @account.friends_timeline.map {|t| "#{t.user.screen_name}> #{t.text}"}
    texts.join("\n") + "\n"
  end

  def direct_messages
    texts = @account.direct_messages.map {|t| "#{t.sender.screen_name}> #{t.text}"}
    texts.join("\n") + "\n"
  end

  def updates
    texts = @account.user_timeline.map {|t| "#{t.user.screen_name}> #{t.text}"}
    texts.join("\n") + "\n"
  end

  def replies
    texts = @account.replies.map {|t| "#{t.user.screen_name}> #{t.text}"}
    texts.join("\n") + "\n"
  end

  def update(msg)
    @account.update msg
  end

  def user_timeline(user)
    texts = Twitter::Search.new(user).map {|t| "#{t.from_user}> #{t.text}"}
    texts.join("\n") + "\n"
  end

  def favorites
    texts = @account.favorites.map {|t| "#{t.user.screen_name}> #{t.text}"}
    texts.join("\n") + "\n"
  end

  def status(id=@twitter_id)
    @account.status(id)
  end

end
