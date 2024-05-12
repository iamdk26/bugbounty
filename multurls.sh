#!/bin/bash

echo -e $Yellow "

███╗░░░███╗██╗░░░██╗██╗░░░░░████████╗██╗██╗░░░██╗██████╗░██╗░░░░░░██████╗
████╗░████║██║░░░██║██║░░░░░╚══██╔══╝██║██║░░░██║██╔══██╗██║░░░░░██╔════╝
██╔████╔██║██║░░░██║██║░░░░░░░░██║░░░██║██║░░░██║██████╔╝██║░░░░░╚█████╗░
██║╚██╔╝██║██║░░░██║██║░░░░░░░░██║░░░██║██║░░░██║██╔══██╗██║░░░░░░╚═══██╗
██║░╚═╝░██║╚██████╔╝███████╗░░░██║░░░██║╚██████╔╝██║░░██║███████╗██████╔╝
╚═╝░░░░░╚═╝░╚═════╝░╚══════╝░░░╚═╝░░░╚═╝░╚═════╝░╚═╝░░╚═╝╚══════╝╚═════╝░
          
    @iamDK26 aka CISCO  Credits: https://github.com/Imran407704
"

# Check if the correct number of arguments is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <domain>"
    exit 1
fi

domain=$1

# Check if the target file exists in the current directory
if [ ! -f "$domain.txt" ]; then
    echo "Target file '$domain.txt' not found in the current directory."
    exit 1
fi

# Get the full path of the target file
target="$(pwd)/$domain.txt"

printf "Total Targets: $(wc -l "$target" | awk '{print $1}')\n"
mkdir -p multiurls
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
printf "Waybackurls Started\n"
cat "$target" | waybackurls | anew multiurls/waybackurls.txt > /dev/null
printf "✅ Waybackurls data: $(wc -l multiurls/waybackurls.txt | awk '{print $1}')\n"

echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
printf "Gau-Plus Started\n"
cat "$target" | gauplus | anew multiurls/plus-gau.txt > /dev/null
printf "✅ Plus-gau data: $(wc -l multiurls/plus-gau.txt | awk '{print $1}')\n"

echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
printf "Gau Data Started\n"
cat "$target" | gau --subs | anew multiurls/gau.txt > /dev/null
printf "✅ Gau data: $(wc -l multiurls/gau.txt | awk '{print $1}')\n"

echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
printf "Katana Data Started\n"
katana -u "$target" -silent  -jc | anew multiurls/katana.txt > /dev/null
printf "✅ Katana data: $(wc -l multiurls/katana.txt | awk '{print $1}')\n"

echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
printf "Hakrawler Data Started\n"
cat "$target" | httprobe | hakrawler -subs -u | anew multiurls/hakrawler.txt > /dev/null
printf "✅ Hakrawler data: $(wc -l multiurls/hakrawler.txt | awk '{print $1}')\n"

echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
printf "Waymore Data Started\n"
waymore -i "$target" -mode U -oU multiurls/waymore.txt
printf "✅ Waymore data: $(wc -l multiurls/waymore.txt | awk '{print $1}')\n"

cat multiurls/waybackurls.txt multiurls/plus-gau.txt multiurls/gau.txt multiurls/katana.txt multiurls/hakrawler.txt multiurls/waymore.txt | sort -u | anew multiurls/all-urls.txt > /dev/null

echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

printf "Total all-urls: $(wc -l multiurls/all-urls.txt)\n"

echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
