#!/usr/bin/expect -f

if $argc==0 {
                send_user "USAGE:\n\tmSysRq.sh terminal_server_ip_for_the_target port sysrq_log\n\n"
                exit
            } 
set timeout 20
set ip [lindex $argv 0]
set port [lindex $argv 1]
set test FAIL
set flag 1

spawn telnet $ip $port
send "\r"
sleep 3
send ""
sleep 2

expect "telnet" {
send "send brk\r"
sleep 2 
send "q"
sleep 2
set flag 0
}

expect "SysRq:" {
    send "\r"
    send "\r"
set test PASS
set flag 0
}

send "\r"
sleep 2 

send ""
sleep 2
expect "telnet" {send "q\r"}
sleep 2
expect {
"telnet" {send "q\r"}
"close" {send "\r"}
}

sleep 2
send "\r"
send_user "\n"
send_user "$test\r"
exit $flag 
