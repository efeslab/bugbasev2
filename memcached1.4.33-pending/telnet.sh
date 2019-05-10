#!/usr/bin/expect

spawn telnet 127.0.0.1 11211
for {set NUM 0} {$NUM < 9999} {incr NUM} {
  if { $NUM / 10 == 0 } {
    send "set key$NUM 0 0 1\r"
    send "$NUM\r"
    expect "STORED"
    continue
  }
  if { $NUM / 100 == 0 } {
    send "set key$NUM 0 0 2\r"
    send "$NUM\r"
    expect "STORED"
    continue
  }
  if { $NUM / 1000 == 0 } {
    send "set key$NUM 0 0 3\r"
    send "$NUM\r"
    expect "STORED"
    continue
  }
  if { $NUM / 10000 == 0 } {
    send "set key$NUM 0 0 4\r"
    send "$NUM\r"
    expect "STORED"
    continue
  }
  if { $NUM / 100000 == 0 } {
    send "set key$NUM 0 0 5\r"
    send "$NUM\r"
    expect "STORED"
    continue
  }
}
send "lru_crawler metadump all\r"
send "quit\r"
close
