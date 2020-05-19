#!/bin/bash

#haeder
# cat<< EOF
#
# EOF

GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
CLEAR="\e[0m"

print_terminal(){
  STATUS=$2
  case "$STATUS" in
    true)
      echo -e "$GREEN[+]$CLEAR $1"
      ;;
    false)
      echo -e "$RED[-]$CLEAR $1"
      ;;
    *)
      echo -e "$YELLOW[+]$CLEAR $1"
      ;;
  esac
}



encry(){
  print_terminal "Start encrytion of file $1"

  if [ -f $1 ]; then
    print_terminal " File to encrypt exist" true
    if [ -f $2 ]; then
      print_terminal " Public-key does exist" true
      openssl rand -base64 32 > key.bin
      # openssl rand -hex 64 -out key.bin
      openssl aes-256-cbc -a -pbkdf2 -salt -in $1 -out $1.enc -k $(cat key.bin)
      openssl rsautl -encrypt -pubin -inkey <(ssh-keygen -e -f $2 -m PKCS8) -in key.bin -out key.bin.enc && rm -f key.bin
      print_terminal " File to encrypted $1 > $1.enc" true
    else
      print_terminal " Public-key does not exist" false
    fi
  else
    print_terminal " File to encrypt does not exist $1" false
  fi
}

decry(){
  if [ -f $1 ]; then
    print_terminal " File to dencrypt exist" true
    if [ -f ]; then
      print_terminal " File to key.bin.enc exist" true
      if [ -f $2 ]; then
        print_terminal " Private-key does exist" true
        openssl rsautl -decrypt -inkey $2 -in key.bin.enc -out key.bin && rm -f key.bin.enc
        openssl aes-256-cbc -d -a -pbkdf2 -in $1 -out ${1:0:$((length-4))} -k $(cat key.bin)
      else
        print_terminal " Private-key does not exist" false
      fi
    else
      print_terminal " Key encription file does not exist on the same folder" false
    fi
  else
    print_terminal " File to dencrypt does not exist $1" false
  fi

}

test_thinngs(){
  length=${#1}
  echo ${1:0:$((length-4))}
}

option=$1
file_input=$2
pub_or_private=$3

case "$option" in
  enc)
    encry $file_input $pub_or_private
    ;;
  dec)
    decry $file_input $pub_or_private
    ;;
  *)
    test_thinngs $file_input $pub_or_private
    echo "Wrong option (set help guide)"
esac
