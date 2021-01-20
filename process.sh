FTP=`jq '. | .ftp' parameters.json | sed 's/"//g'`
SFTP=`jq '. | .sftp' parameters.json | sed 's/"//g'`
APP=`jq '. | .app' parameters.json | sed 's/"//g'`
INTERFACE=`jq '. | .interface' parameters.json | sed 's/"//g'`
iptables -A INPUT -i $INTERFACE -p tcp --dport $FTP -j ACCEPT
iptables -A INPUT -i $INTERFACE -p tcp --dport $SFTP -j ACCEPT
iptables -A INPUT -i $INTERFACE -p tcp --dport $APP -j ACCEPT
iptables -A PREROUTING -t nat -i $INTERFACE -p tcp --dport $FTP -j REDIRECT --to-port $APP
iptables -A PREROUTING -t nat -i $INTERFACE -p tcp --dport $SFTP -j REDIRECT --to-port $APP

