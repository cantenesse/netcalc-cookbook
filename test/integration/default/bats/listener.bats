#!/usr/bin/env bats

@test "netcalc_listener.py is where it should be" {
  run ls /home/tornado/netcalc/app/netcalc_listener.py
  [ "$status" -eq 0 ]
}
