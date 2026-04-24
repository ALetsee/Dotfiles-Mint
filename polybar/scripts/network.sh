#!/bin/bash

iface=$(ip route | awk '/default/ {print $5; exit}')
ip=$(ip -4 addr show "$iface" | grep -oP '(?<=inet\s)\d+(\.\d+){3}')

if [[ "$iface" == en* ]]; then
    echo "󰈀 $ip"
elif [[ "$iface" == wl* ]]; then
    echo "󰤨 $ip"
else
    echo ""
fi
