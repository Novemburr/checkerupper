#checkerupper

A simple bash command to check up on sites;

#TO DO:

Add ease of use commands;

Look into better handling of responses from curl;

Add a sufficient number of test sites with varying response codes;

Allow files to be passed as arguments, may require switches or even....reading user input...my god..;

Investigate 503 also showing up when a 403 is present;
```
grep '500' error_codes.csv 
500,Internal Server Error,The server encountered an unexpected condition which prevented it from fulfilling the request.
503,Service Unavailable,The server is currently unable to handle the request due to a temporary overloading or maintenance of the server. The implication is that this is a temporary condition which will be alleviated after some delay. If known, the length of the delay MAY be indicated in a Retry-After header. If no Retry-After is given, the client SHOULD handle the response as it would for a 500 response.
```

#USAGE:

Populate a sites.txt file with the sites you wish to check in the same directory as auto_checker.sh;

If you want to send to a number of emails you may populate a file email_list.txt;

Basic usage from command line:
./auto_checker.sh email@domain.com;
\#This will run the command and send the output only to the email specified in the argument;

Advanced usage reading from the email_list.txt:
./auto_checker.sh
\#This will run the command and send the output to the emails located in the email_list.txt file, note currently this sends separate mails for each user but not each site;

For email_list.txt make sure the emails are on separate lines.
```
Good:
yes@domain.com
this@domain.com
works@domain.com
```

```
Bad:
nope@domain.com, fail@domain.com, lol@domain.com
```
\#This format may be implemented later depending on my laziness factor;

The sites.txt file fits the same format:
```
Good:
google.com
linux.com
potatoe.com
```

```
Bad:
microsoft.com, lolcatsjpg.com, oranges.com
```
