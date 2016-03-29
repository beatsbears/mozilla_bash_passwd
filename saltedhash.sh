#!/bin/bash
## Andrew Scott
## 3/23/2016

# Demonstrates how salts can add protection against Rainbow Table Attacks

# number of hashes we'll create
HASHRANGE=10

# declare an empty array
declare -a HASHARRAY

# each iteration we will generate a new base64 encoded 16 byte salt
for i in `seq 1 $HASHRANGE`; do
    HASHARRAY[$i]=$(openssl rand 16 -base64)
done

echo "[+] Writing passwords to "$PWD"/saltedhashes.txt" 

# if this file already exists, delete it since we'll be appending
if [ -f saltedhashes.txt ]; then
	rm saltedhashes.txt
fi

# We'll use the same password of "weak" for every entry. 
# This will demonstrate that by using a short hash for each entry, we end up with a 
# drastically different hash in the end.  Even if an attacker has all of these hashes
# they will still need to spend time cracking each hash individually
echo "| Password | Salt | Sha-1(Salt+Password) |" >> saltedhashes.txt
for i in `seq 1 $HASHRANGE`; do
	SALTED=${HASHARRAY[$i]}"weak"
	HASH=$(echo -n $SALTED | openssl dgst -sha1)
	echo "| weak | "${HASHARRAY[$i]}" | "$HASH" |" >> saltedhashes.txt
done