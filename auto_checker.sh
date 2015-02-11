#!/bin/bash
if [ -a output.txt ]
then
	rm output.txt;
fi

touch output.txt;
while read file; do
        curl -sL -w "%{http_code} %{url_effective}\\n" "$file" -o /dev/null >> output.txt &
done < ./sites.txt;

sed -i "/^\(0\|1\|2\|3\)/d" output.txt;
cut -d' ' -f1 output.txt | uniq | grep -w -f - error_codes.csv >> output.txt;
sed -i "s/\.$/\.\n/g" output.txt;
#sed -i "s/[a-zA-z]\,[a-zA-Z]/\n/g" output.txt;
sed -i "s/\,/\,\ /g" output.txt;
if [ -s output.txt ]
then
	echo "$(date +%h)" >> debug.log;
	COUNT=$(wc -l debug.log);
	if [ "$COUNT" -lt 4 ]
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
	:
	fi
else
	if [ $1 ]
	then
		echo 'empty output';
	fi
fi      
NOW=$(date +%H);
THEN=$(head -n 1 debug.log)
if [ "$NOW" == "$THEN" ];
then
	:
else
	if [ -a debug.log ];
	then
		rm debug.log;
		touch debug.log;
	else
		touch badthing.log;
		echo "Something happened causing debug.log to disapear prematurely" >> badthing.log;
		touch debug.log;
	fi
fi

if [ -a output.txt ]
then
	rm output.txt;
fi
