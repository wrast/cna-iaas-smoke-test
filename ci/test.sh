#!/usr/bin/expect

set host $env(host_name)
set user $env(host_user)
set password $env(host_password)
set remotePath $env(host_path)
set prompt $env(host_prompt)
set platform $env(host_platform)

spawn ssh $user@$host

#expect "Are you sure you want to continue connecting (yes/no)?"
#send "yes\n"

expect "password:"
send "$password\n"

expect "$prompt"
send "cd $remotePath/smoke-test\n"

#expect "smoke-test$ "
send "export IAASTESTCONFIGDIR=./\n"
send "chmod +x ./IaaSSmokeTest_$platform\n"
send "./IaaSSmokeTest_$platform\n"

# this expect will just timeout after 10 sec - fake "sleep" waiting for ports to open
# default expect timeout is 10 sec. use "set timeout X" to change default.
expect "fake sleep"
send "\n"

expect "Hit Enter to shutdown listeners:"
send "\n"

expect "$prompt"
send "exit\n"

interact
