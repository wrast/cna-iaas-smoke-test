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

send "cd $remotePath/smoke-test\n"
send "export IAASTESTCONFIGDIR=./\n"
send "chmod +x ./IaaSSmokeTest_$platform\n"
send "./IaaSSmokeTest_$platform\n"

# wait a couple seconds before telling program to continue
sleep 2
send "\n"

expect {
  "Hit Enter to shutdown listeners:" {
    send "\n"
    exp_continue
  }

  -re $multiprompt {
    send "exit\n"
  }
}

#interact
