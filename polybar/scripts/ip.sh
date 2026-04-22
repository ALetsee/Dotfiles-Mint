#!/bin/bash
if ip route | grep -q default.*eth; then
    IFACE=$(ip route | grep default | grep eth | awk '{print $5}' | head -1)
    IP=$(ip addr show $IFACE | awk '/inet /{print $2}' | cut -d/ -f1)
    echo "🔌 $IP"
elif ip route | grep -q default.*wl; then
    IFACE=$(ip route | grep default | grep wl | awk '{print $5}' | head -1)
    IP=$(ip addr show $IFACE | awk '/inet /{print $2}' | cut -d/ -f1)
    echo " $IP"
else
    echo "No network"
fi
