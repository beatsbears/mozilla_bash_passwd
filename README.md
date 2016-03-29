# Password Storage Fundamentals with Bash
---
[Read more here.](https://www.google.com)

## Plaintext Storage
Stores the users plaintext password in a password file.  This may not work on some platforms due to htpasswd.

**Usage**
> sh plaintxt.sh `<password to store>`


## Hashed Storage
An example of password storage using several different hashing algorithms.

**Usage**
> sh hashtxt.sh


## Hashes with Salts
An exmaple of how different random Salt values will result in different hashes, even with the same password.

**Usage**
> sh saltedhash.sh


## Salt + Pepper (Mozilla example)

Implementing Mozilla's Password storage protocol in a bash script
Read more here: https://wiki.mozilla.org/WebAppSec/Secure_Coding_Guidelines#Password_Storage

**Usage**
First make mozpass.sh executable 
> chmod +x mozpass.sh

To generate a new nonce for the hmac hasher, you can use the following command.  You will use this .seed file later to generate the final bcrypt hash.
> ./mozpass.sh -g 

To create a new hash use the following
> ./mozpass.sh -h `<path to seed>` `<Password>` `<Cost 4-31>`

To verify a password against a stored hash
> ./mozpass.sh -c `<path to seed>` `<Password to test>` `<path to hash>` 


## Hashing Speeds
An example of how different algorithms generate hashes at different speeds. 

**Usage**
> sh timedhash.sh


`andrew.scott<at>drownedcoast.xyz`
