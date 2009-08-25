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
    format_tweet(@account.friends_timeline) do |t|
      t.user.screen_name
    end
  end

  def direct_messages
    format_tweet(@account.direct_messages) do |t|
      t.sender.screen_name
    end
  end

  def updates
    format_tweet(@account.user_timeline) do |t|
      t.user.screen_name
    end
  end

  def replies
    format_tweet(@account.replies) do |t|
      t.user.screen_name
    end
  end

  def favorites
    format_tweet(@account.favorites) do |t|
      t.user.screen_name
    end
  end

  def user_timeline(user)
    format_tweet(Twitter::Search.new(user)) do |t|
      t.from_user
    end
  end

  def format_tweet(base)
    texts = base.map {|t| "#{yield(t)}> #{t.text}"}
    texts.join("\n") + "\n"
  end


  def update(msg)
    @account.update msg
  end

  def status(id=@twitter_id)
    @account.status(id)
  end

end
