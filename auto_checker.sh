#!/bin/bash
if [ -a output.txt ]
then
	rm output.txt;
fi

touch output.txt;
while read file; do
        curl -sL -w "%{http_code} %{url_effective}\\n" "$file" -o /dev/null >> output.txt &
done < sites.txt;

sed -i "/^\(0\|1\|2\|3\)/d" output.txt;
cut -d' ' -f1 output.txt | uniq | grep -w -f - error_codes.csv >> output.txt;
sed -i "s/\.$/\.\n/g" output.txt;
#sed -i "s/[a-zA-z]\,[a-zA-Z]/\n/g" output.txt;
sed -i "s/\,/\,\ /g" output.txt;
if [ -s output.txt ]
then

        if [ $1 ]
        then
                mail -s "Sites Down" $1 < output.txt;
		echo 'mail sent';
                #rm output.txt
        else
                if [ -s email_list.txt ]
                then
                        while read file; do
                                mail -s "Sites Down" $file < output.txt;
                        done < email_list.txt;
                else
                        :
                fi
                #rm output.txt
        fi
else
	if [ $1 ]
	then
		echo 'empty output';
	fi
fi      

if [ -a output.txt ]
then
	rm output.txt;
fi
