#!/bin/bash
pokus=1
nothere="0"
isthere="0"
read -p "Hoow many letters you wish to guess?: " numberofletters
desired_string=$(cat sources-of-library/all/all.txt | grep -oE ".{$numberofletters}" | shuf -n 1)

numofpossibilities=$(cat sources-of-library/all/all.txt | grep -oE ".{$numberofletters}" | wc -l)
visible_string=$(echo $desired_string | sed s/[a-zA-Z]/*/g)
while [ $pokus -le 10 ]
do
  echo Nasleduje pokus cislo $pokus, pocet moznosti $numofpossibilities.
  numberofunknown_old=$(echo "$visible_string" | grep -ob "*" | wc -l)
  echo "$visible_string"
  read -p "Guess a letter: " -n1 letter
  echo ""
  if [ "$letter" = "*" ];
  then
    indexofrandom_letter=$(echo "$visible_string" | grep -ob "*" | grep -oE "[0-9]+" | shuf -n 1)
    letter=${desired_string:$indexofrandom_letter:1}
  fi
  guestletters="$guestletters""$letter"
  visible_string=$(echo "$desired_string" | sed "s/[^_$guestletters]/*/g")
  numberofunknown_new=$(echo "$visible_string" | grep -ob "*" | wc -l)
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
  tester=$(echo "$visible_string" | sed 's/\*/./g')
  echo "tester: $tester"
  numofpossibilities=$(cat sources-of-library/all/all.txt | grep -oE ".{$numberofletters}" | grep -v ["$nothere"] | grep ^"$tester"$| wc -l)

done
if [ $pokus -ge 10 ]
then
   echo You have lost. The correct answer is \"$desired_string\"
fi
