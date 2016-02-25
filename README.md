# Mozpass
Implementing Mozilla's Password storage protocol in a bash script
Read more here: https://wiki.mozilla.org/WebAppSec/Secure_Coding_Guidelines#Password_Storage

**Usage**
To generate a new nonce for the hmac hasher, you can use the following command.  You will use this .seed file later to generate the final bcrypt hash.
> sh mozpass.sh -g 

To create a new hash use the following
> sh mozpass -h `<path-to-seed-file>` `<Password>` `<Cost (optional)>`

I'm still working to find a way to verify these hashes from the command line, but I've checked that they're valid using other tools such as python's bcrypt 2.0.0

`andrew.scott<at>drownedcoast.xyz`
