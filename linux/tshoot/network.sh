# ============================================================
# CLIENT / NETWORK DIAGNOSTICS
# ============================================================

# Check which route/interface will be used to reach the backend server
ip route get ip

# Trace the network path to the backend server
traceroute ip

# Check DNS resolution for another domain used for comparison
dig +short example.com

# Test whether TCP port 443 is reachable on the public IP
nc -vz -w 5 IP PORT


# Test the backend application directly without going through the reverse proxy
curl -v --connect-timeout 5 http://192.168.1.12:8080/ -o /dev/null

# Fetch only HTTP response headers from the backend
curl -I http://192.168.1.12:8080

# Follow redirects and inspect the complete HTTP request/response flow
curl -L -v http://192.168.1.12:8080/ -o /dev/null

# Test the website through a specific IP without changing public DNS
curl -vk --resolve semega.ir:443:46.245.81.115 https://example.com/ -o /dev/null

# Test the Nginx virtual host locally on the reverse proxy
curl -vk --resolve semega.ir:443:127.0.0.1 https://example.com/ -o /dev/null


# ============================================================
# NGINX / REVERSE PROXY DIAGNOSTICS
# ============================================================

# Validate Nginx configuration syntax
sudo nginx -t

# Display the complete active Nginx configuration and locate semega.ir
sudo nginx -T | grep -n -A25 -B5 'server_name.*example.com'

# Check whether Nginx is listening on ports 80 and 443
sudo ss -ltnp | grep -E ':80|:443'

# Check Nginx service status
sudo systemctl status nginx --no-pager

# Watch semega.ir access and error logs in real time
sudo tail -f \
  /var/log/nginx/error-example.com.log \
  /var/log/nginx/access-example.com.log


# ============================================================
# BACKEND SERVER / FIREWALL DIAGNOSTICS
# ============================================================

# Check which processes are listening on TCP port 443
sudo ss -ltnp | grep ':443'

# Check which processes are listening on ports 80/8080
sudo ss -ltnp | grep -E ':80|:8080'

# Display current iptables filter rules
sudo iptables -S

# Check UFW status and active policy
sudo ufw status verbose


# ============================================================
# PACKET CAPTURE / TCPDUMP
# ============================================================

# Capture incoming TCP SYN packets destined for port 443
sudo tcpdump -ni any \
  'tcp dst port 443 and tcp[tcpflags] & tcp-syn != 0'

# Capture HTTPS traffic from/to a specific client public IP
sudo tcpdump -ni any \
  'host 130.185.123.149 and tcp port 443'

# Capture full verbose packet contents for HTTPS traffic from a specific client
sudo tcpdump -ni any -s0 -vvv -X \
  'host 130.185.123.149 and tcp port 443'


