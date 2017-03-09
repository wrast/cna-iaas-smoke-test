#!/usr/bin/expect

#SMOKETEST_USER=ubuntu
#SMOKETEST_HOST=172.28.10.234
#SMOKETEST_PATH=.
#SMOKETEST_PASSWORD=welcome1

#spawn scp -r scp.yml $SMOKETEST_USER@$SMOKETEST_HOST:$SMOKETEST_PATH
#expect "password:"
#send "$SMOKETEST_PASSWORD\n"
#interact

spawn scp -r smoke-test ubuntu@172.28.10.234:.

expect "(yes/no)?"
send "yes\n"

expect "password:"
send "welcome1\n"

interact
