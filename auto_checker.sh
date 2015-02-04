#!/bin/bash
#xargs wget < /root/site_list/sites.txt
#wget $(< /root/site_list/sites.txt);
#wget -o log.txt -i /root/testzone/site_list/sites.txt;
while read file; do
	wget -a /root/testzone/log.txt -c $file;
	#wget -c $file | xargs awk '$1 > 400  {print $0;}';
	#wget -c $file > output.txt
	awk '$4 > 400' /root/testzone/log.txt >> bawk.txt
done < /root/testzone/site_list/sites.txt; 
