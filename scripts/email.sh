#!/bin/bash

# Email bash script to email results during HashClash process.

# Email username.
if [ $1==""]; then
  $1=fakeuser@gmail.com # TODO(mmezher): add error code for no username entered. 
fi

user=$1

# Email password. 
if [ $2==""]; then
  $2=fakepassword # TODO(mmezher): add error code for no password entered. 
fi

pass=$2

# Creates folder for Google certificate for use in email.
certs = "~/.certs"
googcerts = "~/.certs/gmail.crt"

if [ ! -d "$certs"]; then
  mkdir ~/.certs
fi

if [ ! -d "$googcerts"]; then
  certutil -N -d ~/.certs
  openssl s_client -connect smtp.gmail.com:465 | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > ~/.certs/gmail.crt certutil -A -n "Google Internet Authority" -t "C," -d ~/.certs -i ~/.certs/gmail.crt
fi


# Actually sending emails through.
mailx -v -s "Your Collision is Ready" -S smtp-use-starttls -S ssl-verify=ignore -S smtp-auth=login -S smtp=smtp://smtp.gmail.com:587 -s from=$user -S smtp-auth-user=$user -S smtp-auth-password=$pass -S ssl-veify=ignore mmm5fd@virginia.edu -S nssconfig-dir=$certs

