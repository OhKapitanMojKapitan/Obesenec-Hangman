#!/bin/bash
pokus=1
nothere="0"
isthere="0"
read -p "Hoow many letters you wish to guess at least? $numberofletters
actualnumber=0
number_of_words=0
guestletters="_"
while [ $actualnumber -ge $numberofletters ];
do
	des_str_part=$(cat sources-of-library/all/all.txt | shuf -n 1)
	echo "$des_str_part"
	desired_string="$desired_string""_""$des_str_part"
	actualnummber=${#desired_string}
	numberofwords=$(($numberofwords+1))
done

# desired_string=$(cat sources-of-library/all/all.txt | grep -oE ".{$numberofletters}" | shuf -n 1)

# numofpossibilities=$(cat sources-of-library/all/all.txt | grep -oE ".{$numberofletters}" | wc -l)
visible_string=$(echo $desired_string | sed s/[a-zA-Z]/*/g)
while [ $pokus -le 10 ];
do
	echo "Nasleduje pokus cislo $pokus typovane pismena $guestletters"
  # , pocet moznosti $numofpossibilities.
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
  # tester=$(echo "$visible_string" | sed 's/\*/./g')
  # echo "tester: $tester"
  # numofpossibilities=$(cat sources-of-library/all/all.txt | grep -oE ".{$numberofletters}" | grep -v ["$nothere"] | grep ^"$tester"$| wc -l)
  # if [ $numofpossibilities -eq 1 ];
  # then
  # 	  slovo=$(echo $desired_string | sed 's/\(.\)/\[\1\U\1\]/g');desc=$(dict $desired_string 2> e.txt | sed -n '/Usage:/,/\[[0-9a-zA-Z]*\]/p' | sed "s/$slovo/X/g" | tr -d '\n')
  # 	  echo "$desc"
  # fi

done
if [ $pokus -ge 10 ];
then
   echo You have lost. The correct answer was $desired_string
fi

