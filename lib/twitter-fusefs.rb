require 'fusefs'
include FuseFS
require 'pp'

class TwitterFuseFS < FuseFS::FuseDir
  def initialize
    @twitter_user = TwitterAccount.new
    @files = %w{ direct_messages updates timeline replies } 
    @dirs = %w{ followers friends }
  end

  def contents(path)
    case path
    when "/"
      @dirs + @files
    when "/friends"
      @twitter_user.friends
    when "/followers"
      @twitter_user.followers
    end
  end

  def file?(path)
    dir, base = scan_path(path)

    root_cond = (@files.include? dir and base.nil?)
    dirs_cond = (@dirs.include? dir and (@twitter_user.friends.include? base or @twitter_user.followers.include? base))

    root_cond or dirs_cond
  end

  def directory?(path)
    dir_items = scan_path(path)
    @dirs.include?(dir_items.last)
  end
end
