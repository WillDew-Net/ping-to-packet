#!/bin/sh

echo ""
echo "===== Centegix Gateway Connectivity Check ====="

# Function for getting EUI 
function get_gateway_id(){
    # find file location that has gateway_id: /etc/config/lora_pkt_fwd
    # extract gateway_id
    # echo gateway_id 
}

# Step 0: Hostname and time
HOST=$(hostname 2>/dev/null)
[ -z "$HOST" ] && HOST="unknown"
# NOTE: add conditional to call get_gateway_id() if there's no hostname
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

# Step 3: Ping Google's DNS IP to test if Cellular Path can reach Internet
GOOGLE_IP=8.8.8.8
echo ""
echo "3. Test Internet Connectivity with Google DNS IP: $GOOGLE_IP"
ping -c 2 -I wwan0 -W 2 $GOOGLE_IP >/dev/null 2>&1
[ $? -eq 0 ] && echo "   Ping Test to $GOOGLE_IP is Reachable" || echo "   
Ping Test to $GOOGLE_IP is Unreachable"

# Step 4: Connectivity Test to Hostnames via wwan0
echo ""
echo "4. Connectivity Test to Hostnames via wwan0:"
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

# Step 5: Active connections (filtered by wwan0 IP)
echo ""
echo "5. Active Connections (Bound to $CELL_IP):"
if [ -n "$CELL_IP" ]; then
  netstat -anp 2>/dev/null | grep "$CELL_IP" | sed 's/^/   /'
else
  echo "   Skipped — No valid IP found on wwan0"
fi

echo ""
echo "===== Diagnostics Complete ====="

