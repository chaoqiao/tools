#!/bin/bash
##########################step1 define IP and Hostname ##########################

Master_Hostname=k8s-master
Worker1_Hostname=k8s-worker1
Worker2_Hostname=k8s-worker2
Master_IP=192.168.1.200
Worker1_IP=192.168.1.201
Worker2_IP=192.168.1.202
Gateway=192.168.1.1
DNS1=223.5.5.5
DNS2=8.8.8.8

#if init worker node, change to worker IP and hostname
IP=$Master_IP
Hostname=$Master_Hostname

#setup hostname and hosts
echo $Hostname > /etc/hostname
echo $Master_IP $Master_Hostname >> /etc/hosts
echo $Worker1_IP $Worker1_Hostname >> /etc/hosts
echo $Worker2_IP $Worker2_Hostname >> /etc/hosts

#####################step2 set static IP #######################################

#use shell array get network interfaces
eni=(`ip addr | grep -E "[0-9]: [a-z]+[0-9]?[a-z]?[0-9]?:" | grep -v -E "lo|docker0" | awk -F : '{print $2}'`)
#set static ip to eni[0] 
[ -e /etc/sysconfig/network-scripts/ifcfg-${eni[0]} ] && cp  /etc/sysconfig/network-scripts/ifcfg-${eni[0]} ~/ && \
cat << EOF > /etc/sysconfig/network-scripts/ifcfg-${eni[0]} 
TYPE=Ethernet
BOOTPROTO=none
DEFROUTE=yes
IPV4_FAILURE_FATAL=no
IPV6INIT=yes
IPV6_AUTOCONF=yes
IPV6_DEFROUTE=yes
IPV6_FAILURE_FATAL=no
NAME=${eni[0]}
DEVICE=${eni[0]}
ONBOOT=yes
DNS1=$DNS1
DNS2=$DNS2
IPADDR=$IP
PREFIX=32
GATEWAY=$Gateway
IPV6_PEERDNS=yes
IPV6_PEERROUTES=yes
EOF

#restart network and reboot
systemctl restart network && reboot

