#!/bin/bash
# Email script based off of directions for email sending via https://kompjuteras.com/en/how-to-send-email-with-mailx-and-external-google-smtp-server-from-centos-linux/
# Email bash script to email results during HashClash process.
# Change $YOUREMAILHERE to whatever your email is. Ask for the username and password to use in this script!
# User must have heirloom-mailx installed.

# Email for sending.
user=$1
echo "$user"
# Email password. 
pass=$2
echo "$pass"
# Username of receiving email.
rec=$3
echo "$rec"
# Creates folder for Google certificate for use in email. This has been added to instructions rather than automated.
# certs="~/.certs"
# googcerts="~/.certs/gmail.crt"
# count=100
#if [ "$count" -eq 10 ]
#then
#mkdir "~/.certs"
#fi
#if [ ! -d "$googcerts"]; then
#  certutil -N -d "~/.certs"
#  openssl s_client -connect smtp.gmail.com:465 | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > "~/.certs/gmail.crt" certutil -A -n "Google Internet Authority" -t "C," -d "~/.certs" -i "~/.certs/gmail.crt"
#fi
# Actually sending emails through.
echo "Attached are your collision files. Enjoy!" | mailx -v -s "Your Collision is Ready" -S smtp-use-starttls -S ssl-verify=ignore -S smtp-auth=login -S smtp=smtp://smtp.gmail.com:587 -S from="$user""(Hash User)" -S smtp-auth-user="$user" -S smtp-auth-password="$pass" -S ssl-verify=ignore -S nss-config-dir="$certs" $rec
