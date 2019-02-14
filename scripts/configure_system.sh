#!/bin/bash
set -e
set -o pipefail
set -x

echo "+) Configuring NTP"
timedatectl set-timezone America/Detroit
echo -e "[Time]\nNTP=0.amazon.pool.ntp.org 1.amazon.pool.ntp.org 2.amazon.pool.ntp.org 3.amazon.pool.ntp.org\nFallbackNTP=0.north-america.pool.ntp.org 1.north-america.pool.ntp.org 2.north-america.pool.ntp.org 3.north-america.pool.ntp.org" > /etc/systemd/timesyncd.conf
timedatectl set-ntp true

echo "+) Configuring firewall"
systemctl mask firewalld
systemctl enable iptables
systemctl enable ip6tables
systemctl stop firewalld
systemctl start iptables
systemctl start ip6tables

echo "+) Loading iptables skeleton"
cat <<- 'EOF' > /etc/sysconfig/iptables
*filter
:INPUT ACCEPT [0:0]
:FORWARD ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]
-A INPUT -i lo -j ACCEPT
-A INPUT -d 127.0.0.0/8 ! -i lo -j DROP
-A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
-A INPUT -p tcp -m state --state NEW -m tcp --dport 22 -j ACCEPT
-A INPUT -p icmp -m icmp --icmp-type 8 -j ACCEPT
-A INPUT -m limit --limit 5/min -j LOG --log-prefix "iptables denied: " --log-level 7
-A INPUT -j DROP
-A FORWARD -j DROP
-A OUTPUT -j ACCEPT
COMMIT
EOF
iptables-restore < /etc/sysconfig/iptables

systemctl enable cloud-init

echo "+) Disable SELinux"
sed -i -e 's/^\(SELINUX=\).*/\1permissive/' /etc/selinux/config
