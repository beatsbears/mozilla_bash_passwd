#!/bin/bash
## Andrew Scott
## 2/24/2016

## Sample usage
### Generate seed
### ./mozpass.sh -g

### Create hash
### ./mozpass.sh -h <seed file path> <Password> <Cost (otpional)>

function mozhashgen () {
	local KEY_ARG=$1
	local PASS_ARG=$2
	local COST_ARG=$3


	# generate a 128 bit random key and base64 encode if no seed is supplied
	if [ -z "$KEY_ARG" ]; then
		# generate a bad default key to use if none is supplied
			KEY=$(echo -n "BADDEFAULTKEY" | openssl enc -base64)
	else
		# if a seed file is passed, use that cryptographically secure value
		if [ ${KEY_ARG: -5} == ".seed" ]; then
			KEY=$(cat $KEY_ARG)
		# otherwise base64 encode whatever string they passed
		else
			KEY=$(echo $2 | openssl enc -base64)
		fi
	fi
	echo "[+] Seed: "$KEY


	# set the password as the passed argument
	PASSWORD=$PASS_ARG
	echo "\n[+] Password used: "$PASSWORD

	# Generate an hmac hash using sha512 and our key from earlier
	HMAC=$(echo -n "$PASSWORD" | openssl dgst -sha512 -hmac "$KEY")
	echo "\n[+] hmac hash: "$HMAC

	# Generate bcrypt using (salt+hmac), user may also optionally specify the bcrypt cost
	if [ -z "$COST_ARG" ]
		then
			HASH=$(echo $HMAC | htpasswd -n -i -B username | tr -d '\n' | awk -F: '{ print $2 }')
	else
		if ! [[ "$COST_ARG" =~ [0-9] ]]
			then
				echo "[!] Cost must be a positive integer, generating hash using Cost=5"
				HASH=$(echo $HMAC | htpasswd -n -i -B username | tr -d '\n' | awk -F: '{ print $2 }')
		else
			HASH=$(echo $HMAC | htpasswd -n -i -B -C $COST_ARG username | tr -d '\n' | awk -F: '{ print $2 }')
		fi
	fi
	echo "\n[+] bcrypt hash: "$HASH

}


function mozseedgen () {
	KEY=$(openssl rand 128 -base64)
	echo $KEY > mozkey.seed
}


# Collect arguements
MODE=$1
SEED=$2
PSWD=$3
CST=$4

if [ "$MODE" == "-g" ]; then
	PWD=$(pwd)
	mozseedgen
	echo "[+] Generating a key at "$PWD"/mozkey.seed"
elif [ "$MODE" == "-h" ]; then
	mozhashgen $SEED $PSWD $CST
elif [ -z "$MODE" ]; then
	echo "You must specify a mode"
	exit 0
else
	echo "mode not recognized"
	exit 0
fi	
