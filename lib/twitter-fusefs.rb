require 'fusefs'
include FuseFS

class TwitterFuseFS < FuseFS::FuseDir
  def initialize
    @twitter_user = TwitterAccount.new
  end

  def contents(path)
    @twitter_user.friends
  end

  def file?(path)
    base, dir = split_path(path)
    @twitter_user.friends.include?(base)
  end
end
