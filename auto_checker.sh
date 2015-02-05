#!/bin/bash
#xargs wget < /root/site_list/sites.txt
#wget $(< /root/site_list/sites.txt);
#wget -o log.txt -i /root/testzone/site_list/sites.txt;
while read file; do
	#wget -a /root/testzone/log.txt -c $file;
	#wget -c $file | xargs awk '$1 > 400  {print $0;}';
	#wget -c $file > output.txt
	#awk '$4 > 400' /root/testzone/log.txt >> bawk.txt
	#curl -s -D - $file -o /dev/null | awk '$1 > 400' { elho $1 > test.txt }
	curl -sL -w "%{http_code} %{url_effective}\\n" "$file" -o /dev/null >> test.txt;
	sed -i '/^\(2\|3\)/d' test.txt;
done < /root/testzone/site_tester/site_list/sites.txt;
