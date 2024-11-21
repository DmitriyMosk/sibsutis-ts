#!/bin/sh

echo "Checking IPVS installation..."
if ! command -v ipvsadm >/dev/null 2>&1; then
  echo "Installing ipvsadm..."
  apk add --no-cache ipvsadm
fi

# Убедитесь, что ip_vs модули загружены
modprobe ip_vs
modprobe ip_vs_rr

echo "Setting up IPVS with Round Robin balancing..."
ipvsadm -C
ipvsadm -A -t 192.168.10.99:80 -s rr

echo "Adding backend servers to IPVS pool..."
ipvsadm -a -t 192.168.10.99:80 -r 192.168.10.101:80 -m
ipvsadm -a -t 192.168.10.99:80 -r 192.168.10.102:80 -m

echo "IPVS setup complete."
ipvsadm -L -n 

sleep infinity
