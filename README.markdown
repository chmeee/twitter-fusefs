# twitter-fusefs

twitter-fusefs is a program to mount your twitter account as a filesystem.

## Directory structure
When you run it it will generate the following directory structure:

    direct_messages  followers/  friends/  README  replies  timeline  updates

### Files
* `direct_messages`: when 'read' will output your direct_messages
* `README`: when 'read' will output some info about twitter-fusefs
* `replies`: when 'read' will output your replies
* `timeline`: when 'read' will output your timeline (with your friends)
* `updates`: when 'read' will output your tweets, when 'written to` will create a new tweet with the msg

### Directories
* `followers/`: has a list of files, each with a follower's nick
* `friends/`: has a list of files, each with a friend's nick

When 'read' from users' files will output his/her timeline, when 'written to' users' files will update your timeline adding @user.

## Install and Use

Until there's a ruby gem you can do the following

1. Install the twitter gem: `sudo gem install twitter`
2. Install [Ruby FuseFS][1] (as far as I know, there's no ruby gem)
3. Download twitter-fusefs, uncompress
4. Create a directory ~/.twitter with

    email: yourtwitteraccountmail
    password: yourcomplexpassword

5. `mkdir` a directory where you want to mount
6. `./bin/twitter-fusefs yourdirectory`

  [1]: http://rubyforge.org/projects/fusefs

Please, note that this script does not require rubygems, as you may not be using it. If you do you'll have to tell ruby so. The best way I think is through

export RUBYOPT="rubygems"

## TO-DO

twitter-fusefs is still in design and development. I'm still thinking about some of the details, so here's a to-do list:

* Use SSL
* Access user status: /status for the mounting user and 'maybe' /(followers|friends)/user_status for the rest of users
* Unfollow people with rm on /friends
* Follow with touch on /friends
* Block with rm on /followers
* Reformat the output of tweets and add more information (like time, app, in respond to, etc.)
* Trends
* Produce a ruby-gem

## Note on Patches/Pull Requests
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but
   bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2009 chmeee. See LICENSE for details.
