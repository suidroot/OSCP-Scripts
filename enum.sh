#!/bin/bash
echo -n "Hostname: "
hostname
echo
echo "################# Whoami"
id
echo
echo "################# Kernel"
uname -a
echo
echo "################# Distro info"
if [ -e /etc/redhat-release ]; then
    cat /etc/redhat-release
elif [ -e /etc/debian_version ]; then 
    cat /etc/debian_version
fi
if [ -e /etc/lsb-release ]; then    
    cat /etc/lsb-release
fi
echo
echo "################# IP info"
/sbin/ifconfig
echo
echo "################# netstat"
netstat -anp
echo
echo "################# Whos there"
who
echo
echo "################# w"
w
echo
echo "################# Last Logins"
last
echo
echo "################# Passwd"
cat /etc/passwd
echo
echo "################# Super Users"
grep -v -E "^#" /etc/passwd | awk -F: '$3 == 0 { print $1}'   # List of super users
awk -F: '($3 == "0") {print}' /etc/passwd   # List of super users

if [ -r /etc/shadow ]; then
    echo "!!!!!!!!!!!!!!!!!!! Shadow file readable"
fi

if [ -w /etc/passwd ]; then
    echo "!!!!!!!!!!!!!!!!!!! passwd file writable"
fi


echo
echo "################# Home dir perms"
ls -l /home
echo
ls -ld /root
echo
echo "################# sudo"
if [ -r /etc/sudoers ]; then
    cat /etc/sudoers
fi
echo "################ sudo with out pw"
sudo -ln
echo "############### sudo WITH pw"
sudo -l
echo
echo "################# mysql running as"
ps aux | grep mysql
echo "#################  Dev tools ****"
find / -name perl* -type f -perm -111 2>/dev/null
find / -name python* -type f -perm -111 2>/dev/null
find / -name gcc* -type f -perm -111 2>/dev/null
find / -name cc -type f -perm -111 2>/dev/null
echo
echo "################# other tools"
find / -name nmap 2>/dev/null
find / -name nc 2>/dev/null
echo

echo "############ SSH"
echo "############## find keys"
find /home -name authorized_keys -exec ls -l {} \; 2>/dev/null
find /home -name ssh_known_hosts -exec ls -l {} \; 2>/dev/null
find /home -name id_rsa* -exec ls -l {} \; 2>/dev/null
echo "############## root login"
grep PermitRootLogin `find /etc -name sshd_config 2>/dev/null` 
echo 
echo "########### .rhosts?"
find / -name .rhosts -exec ls -l {} \; 2>/dev/null

echo
echo "################# Suid files"
find / -perm -4000 -exec ls -l {} \; 2>/dev/null
echo "################# sguid files"
find / -perm -g=s -type f -exec ls -l {} \; 2>/dev/null
#find / -perm -2000 -exec ls -l {} \; 2>/dev/null
echo
echo "################# cron"
crontab -l
ls -alh /var/spool/cron
ls -al /etc/ | grep cron
ls -al /etc/cron*
cat /etc/cron*
cat /etc/at.allow
cat /etc/at.deny
cat /etc/cron.allow
cat /etc/cron.deny
cat /etc/crontab
cat /etc/anacrontab
cat /var/spool/cron/crontabs/root
echo
echo "################# World Writable ***"
find / -writable -type d 2>/dev/null
echo
echo "################# process"
ps aux
echo
echo 
echo "################# Packages"
rpm -aq
dpkg --list
