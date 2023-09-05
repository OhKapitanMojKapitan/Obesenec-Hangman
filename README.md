# Obesenec-Hangman

# Tu budem programovat hru Obesenc v bash. Here I will code a game Hangman in bash.

#1. VYTVORENI KOMPLENEHO ZOZNAMU SLOV Z VIACERYCH ZDROJOV ROZNEJ STRUKTURY. CREATING THE GLOBAL LIST OF WORDS FROM SEVERAL SOURCES OF DIFFERENT FILE STRUCTURE.

# 1.0 List of all animals:
#  1.0.1 Zdroj-Source: https://gist.github.com/atduskgreg/3cf8ef48cb0d29cf151bedad81553a54
grep -v ^[a-z] animals.txt | sed 's/(/-/g' | sed 's/).*$//g' | grep -v 'Common\|Animals' | sed 's/  */ /g' | sed 's/ /_/g' | sort -u | sed 's/_-/-/g' | sed 's/\([^a-zA-Z]\)_/\1/g' > animal_corrected.txt

# 1.1 All words from Holy Bible:
# 1.1.1 Zdroj-Source: https://github.com/scrollmapper/bible_databases_deuterocanonical.git
#  unzip in to the folder 
# 1.1.2 make a complete list of acceptable words
find /absoluteadresstillTXTfolder/txt/ -name "*.txt" -type f | sed 's/ /\\ /g' | awk '{print "cat "$0}' | bash | cut -c 8- | sed 's/[^a-zA-Z ]//g' | sed 's/  */ /g' | tr " " "\n" | grep -v [A-Z] | sort -u | grep -v ^[ivxlcdm][ivxlcdm]*$ | grep -v '^.$\|^..$'
# 1.1.3 save the list in to the HolyBible-WordList_corrected.txt
find ~/Git_notExactlyHub/comparison/sources-of-library/SvatePismo-HolyBible/bible_databases_deuterocanonical-master/txt/ -name "*.txt" -type f | sed 's/ /\\ /g' | awk '{print "cat "$0}' | bash | cut -c 8- | sed 's/[^a-zA-Z ]//g' | sed 's/  */ /g' | tr " " "\n" | grep -v [A-Z] | sort -u | grep -v ^[ivxlcdm][ivxlcdm]*$ | grep -v '^.$\|^..$' > ~/Git_notExactlyHub/comparison/sources-of-library/SvatePismo-HolyBible/HolyBible-WordList_corrected.txt
# 1.2 Vseobecny zoznam slov-General list of words
# 1.2.1 Zdroj-Source: https://www-personal.umich.edu/~jlawler/wordlist
# 1.2.2 Conversion of the list
cat www-personal.umich.edu_~jlawler_wordlist.txt| sed 's/[^a-zA-Z-]//g'| grep -v '^$\|-' > wordlist-personalumichedu_corrected.txt

#Make central wordlist of all words:
# Put all the results in one place.
# 1.3. cat ~/Git_notExactlyHub/comparison/sources-of-library/*/*_corrected.txt | sort -u > ~/Git_notExactlyHub/comparison/sources-of-library/all/all.txt
