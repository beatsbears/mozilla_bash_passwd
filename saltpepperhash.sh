#!/bin/bash
## Andrew Scott
## 3/23/2016

# number of hashes we'll create
HASHRANGE=10

# declare an empty array
declare -a HASHARRAY

# create a global pepper
PEPPER=$(openssl rand 16 -base64)
echo "[+] Random Pepper: "$PEPPER

# each iteration we will generate a new base64 encoded 16 byte salt
for i in `seq 1 $HASHRANGE`; do
    HASHARRAY[$i]=$(openssl rand 16 -base64)
done

echo "[+] Writing passwords to "$PWD"/saltpepperhashes.txt\n" 

# if this file already exists, delete it since we'll be appending
if [ -f saltpepperhashes.txt ]; then
	rm saltpepperhashes.txt
fi

# Method 1 - Least effective method
# We're just concatinating Salt + Password + Pepper then hashing with sha1
# We'll use the same password of "spices" for every entry. 
echo "\nMethod 1" >> saltpepperhashes.txt
echo "| Password | Salt | Sha-1(Salt+Password+Pepper) |" >> saltpepperhashes.txt
for i in `seq 1 $HASHRANGE`; do
	SALTPEPPER=${HASHARRAY[$i]}"spices"$PEPPER
	HASH=$(echo -n $SALTPEPPER | openssl dgst -sha1)
	echo "| spices | "${HASHARRAY[$i]}" | "$HASH" |" >> saltpepperhashes.txt
done

# Method 2 - hash of a hash
# Concatinate Password + Pepper and hash once, then concatinate the first hash and the Salt and hash again

echo "\n\nMethod 2" >> saltpepperhashes.txt
echo "| Password | Salt | Sha-1(Salt+Sha-1(Password+Pepper)) |" >> saltpepperhashes.txt
for i in `seq 1 $HASHRANGE`; do
	PEPPERPASS="spices"$PEPPER
	HASH1=$(echo -n $PEPPERPASS | openssl dgst -sha1)
	SALTHASH=${HASHARRAY[$i]}$HASH1
	HASH2=$(echo -n $SALTHASH | openssl dgst -sha1)
	echo "| spices | "${HASHARRAY[$i]}" | "$HASH2" |" >> saltpepperhashes.txt
done