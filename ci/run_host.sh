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
set user $env(host_user)
set password $env(host_password)
set remotePath $env(host_path)

spawn scp -r smoke-test $user@$host:$remotePath

expect "Are you sure you want to continue connecting (yes/no)?"
send "yes\n"

expect "password:"
send "$password\n"

interact
