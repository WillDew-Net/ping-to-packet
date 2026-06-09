#!/bin/sh

echo ""
echo "===== Centegix Gateway Connectivity Check ====="

# Step 0: Hostname and time
HOST=$(hostname 2>/dev/null)
[ -z "$HOST" ] && HOST="unknown"
echo "Running on $HOST at $(date)"

# Step 1: Interface status
echo ""
echo "1. Interface wwan0 status:"
ip link show wwan0 2>/dev/null | grep -E "<[^>]*UP,LOWER_UP[^>]*>" >/dev/null
[ $? -eq 0 ] && echo "   wwan0 is UP" || echo "   wwan0 is DOWN or not 
found"

# Step 2: IP address on wwan0 (BusyBox-safe with persistent variable)
echo ""
echo "2. IP address on wwan0:"
CELL_IP=""
for IP in $(ip -4 addr show wwan0 | awk '/inet / {print $2}'); do
  CLEAN_IP=$(echo "$IP" | cut -d/ -f1)
  echo "$CLEAN_IP" | grep "^169\." >/dev/null
  if [ $? -ne 0 ]; then
    CELL_IP="$CLEAN_IP"
    break
  fi
done

if [ -n "$CELL_IP" ]; then
  echo "   IP Address: $CELL_IP"
else
  echo "   No valid IP assigned"
fi

# NOTE: Removing this step to remove confusion, since Cell IPs are assigned dynamically
# Step 3: IP assignment type 
# echo ""
# echo "3. IP Assignment Type:"
# ps | grep "udhcpc.*wwan0" | grep -v grep >/dev/null
# [ $? -eq 0 ] && echo "   wwan0 is using DHCP (udhcpc is active)" || echo "   
# wwan0 is likely using a static IP"

# Step 4: Default Gateway
DEFAULT_GW=$(ip route show dev wwan0 | grep "default" | awk '{print $3}')
echo ""
echo "4. Default Gateway: $DEFAULT_GW"
ping -c 2 -I wwan0 -W 2 $DEFAULT_GW >/dev/null 2>&1
[ $? -eq 0 ] && echo "   Ping Test to $DEFAULT_GW is Reachable" || echo "   
Ping Test to $DEFAULT_GW is Unreachable"

# Step 5: Connectivity Test to Hostnames via wwan0
echo ""
echo "5. Connectivity Test to Hostnames via wwan0:"
for HOSTNAME in google.com centegix.wisdm.rakwireless.com centegix.com; do
  for PORT in 80 443; do
    nc -zvw2 $HOSTNAME $PORT >/dev/null 2>&1
    if [ $? -eq 0 ]; then
      printf "   %-40s : Reachable\n" "$HOSTNAME:$PORT"
    else
      printf "   %-40s : Unreachable\n" "$HOSTNAME:$PORT"
    fi
  done
done

# Step 6: Active connections (filtered by wwan0 IP)
echo ""
echo "6. Active Connections (Bound to $CELL_IP):"
if [ -n "$CELL_IP" ]; then
  netstat -anp 2>/dev/null | grep "$CELL_IP" | sed 's/^/   /'
else
  echo "   Skipped — No valid IP found on wwan0"
fi

echo ""
echo "===== Diagnostics Complete ====="

