#!/bin/bash

if [[ "$(whoami)" != "root" ]]; then
  echo $0 must be ran as root!
  exit 1
fi

for i in $(ls /dev/sd[a-z]); do
  echo ================================================================
  echo $i
  smartctl=$(/usr/sbin/smartctl -a $i)
  #Set the field separator to new line
  IFS=$'\n'
  for line in $(echo "$smartctl"); do
    if [[ "$line" =~ "Model Family" ||
          "$line" =~ "Device Model" || 
          "$line" =~ "User Capacity" ||
          "$line" =~ "Firmware Version" ||
          "$line" =~ "Temperature_Celsius" ||
          "$line" =~ "Serial Number" ]]; then
      if [[ "$line" =~ "Temperature_Celsius" ]]; then
        echo $line | awk '{printf("Temperature:\t%dC\t%s %s\n", $10, $11, $12)}'
      else
        echo "$line"
      fi
    fi
  done
done
