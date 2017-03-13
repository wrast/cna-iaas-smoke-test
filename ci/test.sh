#!/usr/bin/expect

set host $env(host_name)
set user $env(host_user)
set password $env(host_password)
set remotePath $env(host_path)

spawn ssh $user@$host

#expect "Are you sure you want to continue connecting (yes/no)?"
#send "yes\n"

expect "password:"
send "$password\n"

expect "$"
send "cd $remotePath/smoke-test\n"

expect "smoke-test$"
send "ls -l\n"

expect "smoke-test$"
set ::env(IAASTESTCONFIGDIR) $remotePath/smoke-test

interact
