# enfile
Bash tool to encrypt and decrypt a file with ssh public and private keys with easy

## Overview
The tool is an abstraction on using openssl to encrypting file using a public and private key.

## Explanation
#### Encryption process
* run the command indicating which file
* The tool use the openssl to create a random base64 to 32 characters and store it in a file created locally named key.bin
* This key.bin files is used to encrypt the files requested
* It create locally a new file with the same name and adds the extension .enc
* After the encrypting the file, the key.bin is encrypted with the public_key and rename key.bin.enc
* Both file with extension .enc should be share. <file_name_to_encrypt>.enc and key.bin.enc

#### Decryption process
* User should received at least 2 files. <file_name_encrypted>.enc and key.bin.enc
* have all files in the same folder
* the running command will look for the beside for the encrypted file and the private key. The key.bin.enc file
* With the private key it will decrypt the file to key.bin
* The file key.bin will be use t decrypt and store it as <file_name_encrypted>

## How to  Instruction
```
./enfile enc <file_to_encrypt> <public_key_to_use>
```

```
./enfile dec <file_to_dencrypt> <public_key_to_use>
```


# Resources
* https://rietta.com/blog/openssl-generating-rsa-key-from-command/
* https://www.devco.net/archives/2006/02/13/public_-_private_key_encryption_using_openssl.php
* https://raymii.org/s/tutorials/Encrypt_and_decrypt_files_to_public_keys_via_the_OpenSSL_Command_Line.html
