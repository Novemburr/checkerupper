#!/bin/bash
rm output.txt;
while read file; do
	curl -sL -w "%{http_code} %{url_effective}\\n" "$file" -o /dev/null >> output.txt;
	sed -i '/^\(1\|2\|3\)/d' output.txt;
	if [ -s output.txt ] 
	then
		if [ $1 ]
		then
			mail -s "Sites Down" $1 < output.txt;
			rm output.txt;
		else
		:
		fi
	fi
done < ./sites.txt;
