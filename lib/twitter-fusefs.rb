require File.join(File.dirname(__FILE__), 'twitter_account.rb')
require 'fusefs'
include FuseFS
require 'pp'

class TwitterFuseFS < FuseFS::FuseDir
  def initialize
    @twitter_user = TwitterAccount.new
    @files_r = %w{ direct_messages favorites README replies timeline } 
    @files_rw = %w{ status updates } 
    @files = @files_r + @files_rw
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

  def read_file(path)
    case path
    when "/timeline"
      @twitter_user.friends_timeline
    when "/direct_messages"
      @twitter_user.direct_messages
    when "/updates"
      @twitter_user.updates
    when "/replies"
      @twitter_user.replies
    when "/status"
      @twitter_user.status
    when "/favorites"
      @twitter_user.favorites
    when "/README"
      "twitter-fusefs\n"
    when /\/(followers|friends)\/(.*)/
      @twitter_user.user_timeline($2)
    end
  end

  def write_to(path, body)
# don't know why it gets executed twice, first time with an empty body
# I guess it's because it first creates an empty file
    if !body.empty? 
      case path
      when "/updates"
        @twitter_user.update body
      when /\/(followers|friends)\/(.*)$/
        body = "@#{$2} #{body}"
        @twitter_user.update body
      end
    end
  end

  def can_write?(path)
    items = scan_path(path)
    root_cond = @files_rw.include?(items[0])
    dirs_cond = (@dirs.include?(items[0]) and !items[1].nil?)
    root_cond or dirs_cond
  end

  def can_delete?(path)
    can_write?(path)
  end
end
