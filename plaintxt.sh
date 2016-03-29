#!/bin/bash
## Andrew Scott
## 3/16/2016

# Creates a sample plaintext password file with the username "plaintest" and a password passed as an arguement

echo "[+] Writing password to "$PWD"/plain.txt" 
htpasswd -p -b -c plain.txt plaintest $1
