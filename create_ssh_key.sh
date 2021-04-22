#!/bin/bash
# This script creates and adds to keyrind an ssh key

ALGORITHM="ed25519"

# Greeting
echo
echo "##################################################################"
echo "create_ssh_key -- Generates an ssh key with $ALGORITHM algorithm"
echo "                  the key is then added to keyring"
echo "##################################################################"
echo

# Generates SSH key
read -p "Enter email: " email

default_file="$HOME/.ssh/id_$ALGORITHM"
read -p "Enter a file in which to save the key [$default_file]: " key_file
key_file=${key_file:-$default_file} # Sets default if empty
echo "Key $key_file"

echo "Generating ssh key with provided email"
ssh-keygen -t $ALGORITHM -C $email -f $key_file
echo "Done"

# Adds key to ssh-agent keyring
echo "Starting ssh-agent (for keyring)"
eval "(ssh-agent -s)"
ssh-add $key_file

# Outputs public key to be copied
echo
echo "Generated public key -- copy & paste where needed (eg. Github)"
cat "$key_file.pub"
