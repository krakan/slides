docker cp exercise workstation:/root/

chef-run web1 exercise/recipes/extra-a.rb

ssh web1 ls -l /tmp/myfile

chef-run web1 exercise/recipes/extra-b1.rb

ssh web1 cat /tmp/whoami

chef-run web1 exercise/recipes/extra-b2.rb

ssh web1 cat /tmp/whoami

chef-run web1 exercise/recipes/extra-c.rb

ssh web1 apt upgrade

chef-run web1,web2,lb exercise

for host in web1 web2 lb
do
   ssh $host cat /tmp/whoami
done
