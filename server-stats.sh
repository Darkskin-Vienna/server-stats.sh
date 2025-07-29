#!/bin/bash

echo "=== server performance stats ==="
echo "Time: $(date)"
echo ""

echo "CPU Usage:"
top -bn1 | grep Cpu

echo "Memory Usage"
free -h

echo "Disk Usage:"
df -h /

echo "Open Ports:"
ss -tuln

echo "User Login History:"
last -a | head -n 5

echo "Network Usage:"
interface=$(ls /sys/class/net/ | grep -v lo | head -n 1)

if [ -n "$interface" ]; then
   rx=$(cat /sys/class/net/$interface/statistics/rx_bytes 2>/dev/null || echo "0")
   tx=$(cat /sys/class/net/$interface/statistics/tx_bytes 2>/dev/null || echo "0")

   rx_mb=$((rx / 1024 / 1024))
   tx_mb=$((tx / 1024 / 1024))

   echo "Interface: $interface"
   echo "Received: ${rx_mb}MB"
   echo "Sent: ${tx_mb}MB"
else
   echo "No network interface found"
fi

echo ""
   
