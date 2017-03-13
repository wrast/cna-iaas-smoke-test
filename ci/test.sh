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

cd smoke-test
send "ls -l\n"
puts "\nReady to run"
exit

interact
