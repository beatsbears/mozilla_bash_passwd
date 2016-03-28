#!/bin/bash
## Andrew Scott
## 3/28/2016

# 100 iterations of SHA1
function sha1time() {
	for i in `seq 1 100`; do
		SHA1=$( echo -n "sample_password" | openssl dgst -sha1)
	done
}

# 100 iterations of SHA256
function sha256time() {
	for i in `seq 1 100`; do
		SHA256=$( echo -n "sample_password" | openssl dgst -sha256)
	done
}

# 100 iterations of MD5
function md5time() {
	for i in `seq 1 100`; do
		MD5=$( echo -n "sample_password" | openssl dgst -md5)
	done
}

# 100 iterations of bcrypt
function bcrypttime() {
	for i in `seq 1 100`; do
		HASH=$(echo -n "sample_password" | htpasswd -n -i -B username)
	done
}


echo "Running 1000 iterations of each hash."
echo "MD5: "
TIMEMD5="$(TIMEFORMAT='%3R'; time md5time 2>&1 1>/dev/null )"
echo "\nSHA1: "
TIMESHA1="$(TIMEFORMAT='%3R'; time sha1time 2>&1 1>/dev/null )"
echo "\nSHA256: "
TIMESHA256="$(TIMEFORMAT='%3R'; time sha256time 2>&1 1>/dev/null )"
echo "\nbcrypt: "
TIMEBCRYPT="$(TIMEFORMAT='%3R'; time bcrypttime 2>&1 1>/dev/null )"

