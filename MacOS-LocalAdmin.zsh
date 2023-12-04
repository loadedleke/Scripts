#!/bin/zsh
# Username and Password to create
username=alcadmin
password="H0w2secure1t4sure!"
# Create User and add to admins
dscl . -create /Users/$username
dscl . -create /Users/$username UserShell /bin/bash
dscl . -create /Users/$username RealName $username
dscl . -create /Users/$username UniqueID "510"
dscl . -create /Users/$username PrimaryGroupID 20
dscl . -create /Users/$username NFSHomeDirectory /Users/$username
dscl . -passwd /Users/$username $password
dscl . -append /Groups/admin GroupMembership $username
# Get list of regular users
users=$(dscl . -list /Users | grep -v -e '_' -e root -e nobody -e daemon -e $username)
# Loop through them and remove them from Admins group
for i in $users
do
dseditgroup -o edit -d $i -t user admin
done