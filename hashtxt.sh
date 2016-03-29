#!/bin/bash
## Andrew Scott
## 3/16/2016

# Creates sample hashes using several different hashing algorithms and saves them to a password file

echo "[+] Writing passwords to "$PWD"/hashes.txt" 
# Sha1 hash
SHA1=$( echo -n "$1" | openssl dgst -sha1)
# Sha2 hash
SHA2=$( echo -n "$1" | openssl dgst -sha256)
# MD5 hash
MD5=$(echo -n "$1" | openssl dgst -md5)


echo "sha1test:"$SHA1"\nsha2test:"$SHA2"\nmd5test:"$MD5 > hashes.txt
