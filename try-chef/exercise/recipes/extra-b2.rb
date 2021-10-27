package 'iproute2'
execute <<-'EOF'
	myip=$(ip a s | grep inet | grep -v 127 | cut -d/ -f1 | sed "s/.* //")
	for host in web1 web2 lb -
        do
            getent hosts $host | grep -q $myip && break
        done
	echo "filen ligger på $host." > /tmp/whoami
EOF
