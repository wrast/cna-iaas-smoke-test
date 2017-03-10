#!/usr/bin/expect

#SMOKETEST_USER=ubuntu
#SMOKETEST_HOST=172.28.10.234
#SMOKETEST_PATH=.
#SMOKETEST_PASSWORD=welcome1

#spawn scp -r scp.yml $SMOKETEST_USER@$SMOKETEST_HOST:$SMOKETEST_PATH
#expect "password:"
#send "$SMOKETEST_PASSWORD\n"
#interact

set host $env(host_name)
# set user [lindex $argv 1]
# set password [lindex $argv 2]
# set remotePath [lindex $argv 3]

spawn scp -r smoke-test $env(host_user)@$host:$env(host_path)

expect "Are you sure you want to continue connecting (yes/no)?"
send "yes\n"

expect "password:"
send "$env(host_password)\n"

interact
