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
