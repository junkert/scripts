#!/bin/bash

echo -e "Drive\t\tManufacturer\t\tCapacity"
for i in $(ls /dev/sd[a-z]); do
  mfg=$(smartctl -a $i 2>/dev/null | grep "Model Family:" | cut -d: -f 2 | tr -d ' ')
  capacity=$(smartctl -a $i 2>/dev/null | grep "User Capacity:" | cut -d: -f 2 | tr -d ' ')
  echo -e "$i\t\t$mfg\t\t$capacity"
done
