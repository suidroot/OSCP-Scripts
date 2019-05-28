#!/bin/sh

cat ~/labartifacts/allcreds.txt | cut -d":" -f1 > ~/labartifacts/userlist.txt
cat ~/labartifacts/allcreds.txt | cut -d":" -f2 > ~/labartifacts/passwordlist.txt
awk 'NF' ~/labartifacts/userlist.txt > ~/labartifacts/userlist.txt.awk
awk 'NF' ~/labartifacts/passwordlist.txt > ~/labartifacts/passwordlist.txt.awk
cat ~/labartifacts/userlist.txt.awk | sort | uniq > ~/labartifacts/userlist.txt
cat ~/labartifacts/passwordlist.txt.awk | sort | uniq > ~/labartifacts/passwordlist.txt
rm ~/labartifacts/userlist.txt.awk ~/labartifacts/passwordlist.txt.awk
#mv ~/labartifacts/userlist.txt.awk ~/labartifacts/userlist.txt
#mv ~/labartifacts/passwordlist.txt.awk ~/labartifacts/passwordlist.txt
echo "" >> ~/labartifacts/passwordlist.txt

