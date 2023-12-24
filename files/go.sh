#!/bin/bash
# serjb 24/12/2023
# ver.1.0

# declare 
# variables
LOCK_FILE=/tmp/myexec.lock
HTTP_ACCESS_FILE=/etc/httpd/logs/access_log
HTTP_ERROR_FILE=/etc/httpd/logs/error_log
MAIL_BIN=/bin/mail
MAIL_ADDRESS=test@bash.ru
CURRDATE=`date +"%e/%b/%C%y:%H:%M:%S %Z"`
LASTDATE=`cat $LOCK_FILE`	
MAX_URL_COUNT=3

# finctions

# begin
echo $CURRDATE > $LOCK_FILE

# 1 ip addrress client and statistic activity
HEADER='    COUNT    IP'
RESULT="$(awk -F " |[][]" '{if ($5 > "'"$LASTDATE"'") print $1}' $HTTP_ACCESS_FILE|sort|uniq -c)"
echo -e "$HEADER\n$RESULT" | $MAIL_BIN -s "IP adress statistic from $LASTDATE to $CURRDATE" $MAIL_ADDRESS

# 2 url statistic
HEADER='    COUNT    URL'
RESULT="$(awk -F " |[][]" '{if ($5 > "'"$LASTDATE"'") print $9}' $HTTP_ACCESS_FILE|sort|uniq -c|awk '{if ($1 > '$MAX_URL_COUNT') print $0}')"
 echo -e "$HEADER\n$RESULT" | $MAIL_BIN -s "URL's statistic get more than $MAX_URL_COUNT times from $LASTDATE to $CURRDATE" $MAIL_ADDRESS

# 3 error list
tail -n +$(grep -nr "httpd running" $HTTP_ERROR_FILE|tail -n1|awk -F ':' '{print $1}') $HTTP_ERROR_FILE | $MAIL_BIN -s "Errors from lastrefresh httpd" $MAIL_ADDRESS

# 4 http code statistic
HEADER='    COUNT    CODE'
RESULT="$(awk -F " |[][]" '{if ($5 > "'"$LASTDATE"'") print $11}' $HTTP_ACCESS_FILE|sort|uniq -c)"
echo -e "$HEADER\n$RESULT" | $MAIL_BIN -s "HTTP CODE statistic from $LASTDATE to $CURRDATE" $MAIL_ADDRESS
