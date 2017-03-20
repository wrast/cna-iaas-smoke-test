#!/usr/bin/expect

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
