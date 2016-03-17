# Mozpass
Implementing Mozilla's Password storage protocol in a bash script
Read more here: https://wiki.mozilla.org/WebAppSec/Secure_Coding_Guidelines#Password_Storage

**Usage**
To generate a new nonce for the hmac hasher, you can use the following command.  You will use this .seed file later to generate the final bcrypt hash.
> ./mozpass.sh -g 

To create a new hash use the following
> ./mozpass.sh -h `<path to seed>` `<Password>` `<Cost 4-31>`

To verify a password against a stored hash
> ./mozpass.sh -c `<path to seed>` `<Password to test>` `<path to hash>` 


`andrew.scott<at>drownedcoast.xyz`
