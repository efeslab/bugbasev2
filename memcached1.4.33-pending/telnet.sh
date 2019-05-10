#!/usr/bin/expect

spawn telnet 127.0.0.1 11211
for {set NUM 0} {$NUM < 1000000} {incr NUM} {
	send "set key$NUM 0 0 0\r"
	send "\r"
	expect "STORED"
}
send "lru_crawler metadump all\r"
interact
send "quit\r"
close
