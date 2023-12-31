#!/bin/bash
pokus=1
nothere="0"
isthere="0"
read -p "How many letters you wish to guess, at least? " numberofletters
if ! [ "$numberofletters" -eq "$numberofletters" ] 2> /dev/null
then
    echo "EXIT: Sorry integers only"
    exit
else
    if [ "$numberofletters" -lt 5 ]
    then
    	echo "EXIT: Sorry. Only integers bigger than 5."
    	exit
    fi
fi
desired_string=$(cat sources-of-library/all/all.txt | shuf -n 1)
actualnumber=${#desired_string}

guestletters="_"\'

while [ $actualnumber -le $numberofletters ]
do
	des_str_part=$(cat sources-of-library/all/all.txt | shuf -n 1)
	desired_string="$desired_string""_""$des_str_part"
	actualnumber=$(echo $desired_string | sed 's/[^a-zA-Z]//g' | wc -c)
done

visible_string=$(echo $desired_string | sed s/[a-zA-Z]/*/g)
clear
while [ $pokus -le 10 ]
do
  grep -A 7 "^$pokus "  hangman.txt
  echo "Nasleduje pokus cislo $pokus, typovane pismena \"$guestletters\""
  numberofunknown_old=$(echo "$visible_string" | grep -ob "*" | wc -l)
  echo "$visible_string"
  read -p "Guess a letter: " -n1 letter
  # While loop for alphanumeric characters and a non-zero length input
  while [[ "$letter" =~ [^a-zA-Z*] || -z "$letter" ]]
  do        
    echo "The input should be just a lowercase letter from \"a\" till \"z\"."     
    read -p "Guess a letter: " -n1 letter
  done
  echo ""
  if [ "$letter" = "*" ];
  then
    indexofrandom_letter=$(echo "$visible_string" | grep -ob "*" | grep -oE "[0-9]+" | shuf -n 1)
    letter=${desired_string:$indexofrandom_letter:1}
  fi
  guestletters="$guestletters""$letter"
  visible_string=$(echo "$desired_string" | sed "s/[^$guestletters]/*/g")
  numberofunknown_new=$(echo "$visible_string" | grep -ob "*" | wc -l)
  clear
  if [ $numberofunknown_new -lt $numberofunknown_old ];
   then
      echo "Correct"
      isthere="$isthere""$letter"
      if [ $numberofunknown_new -eq 0 ];
      then
	      echo YOU ARE SUUCESFULL!!!
	      echo "RESULT: \"$visible_string\"" 
	      break
      fi
   else
      guesedalready=$(echo "$visible_string" | grep -ob "$letter" | wc -l)
      if [ $guesedalready -gt 0 ];
      then
         echo "You have already guesed the \"$letter\" letter."
      else
         echo "The letter \"$letter\" is not present."
	 nothere="$nothere""$letter"
      fi
      pokus=$(( $pokus + 1 ))
  fi

done
if [ $pokus -ge 10 ];
then
   grep -A 7 "^11 "  hangman.txt
   echo "You have lost. The correct answer was \"$desired_string\"."
fi

