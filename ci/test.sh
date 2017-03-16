#!/usr/bin/expect

set host $env(host_name)
set user $env(host_user)
set password $env(host_password)
set remotePath $env(host_path)
#set prompt $env(host_prompt)
set platform $env(host_platform)

set timeout 5

set multiprompt "(%|#|\\$) $"

spawn ssh $user@$host

expect {
  "yes/no" {
    send "yes\r"
    exp_continue
  }

  "assword:" {
    send "$password\r"
    exp_continue
  }

  timeout {
    puts "Connection to $host timed out"
    exit 1
  }

  -re "failed|invalid password|denied" {
    puts "Invalid credentials for user $user"
    exit 1
  }

  -re $multiprompt
}

send "cd $remotePath/smoke-test\r"
send "export IAASTESTCONFIGDIR=./\r"
send "chmod +x ./IaaSSmokeTest_$platform\r"
send "./IaaSSmokeTest_$platform\r"

# give other host a chance to sync up to this point
sleep 5
send "\r"

expect {
  "Hit Enter to shutdown listeners:" {
    sleep 2 # this gives other host a chance to send before we shut down
    send "\r"
    exp_continue
  }

  -re $multiprompt {
    send "exit\r"
  }
}

interact
