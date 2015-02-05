#!/bin/bash
while read file; do
	curl -sL -w "%{http_code} %{url_effective}\\n" "$file" -o /dev/null >> test.txt;
	sed -i '/^\(2\|3\)/d' test.txt;
done < /root/testzone/site_tester/site_list/sites.txt;
