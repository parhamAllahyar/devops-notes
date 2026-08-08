# ============================================================
# MIKROTIK - IP / NAT DIAGNOSTICS
# ============================================================

# Display all IP addresses configured on MikroTik interfaces
/ip address print detail

# Display all destination NAT rules in compact form
/ip firewall nat print terse where chain=dstnat

# Find all NAT rules forwarding traffic to the backend server
/ip firewall nat print detail where to-addresses=192.168.1.12

# Display destination NAT rules with packet/byte counters
/ip firewall nat print detail stats where chain=dstnat

# Search routes related to a specific public IP
/ip route print detail where dst-address~"46.34.167.120"

# Sniff traffic for the problematic public IP on port 443
/tool sniffer quick ip-address=46.34.167.120/32 port=443

# Sniff traffic for the working public IP on port 443
/tool sniffer quick ip-address=46.245.81.115/32 port=443