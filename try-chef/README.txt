docker-compose up -d
docker exec -it workstation bash

chef-run web1 file hello.txt
yes
ssh web1 cat /hello.txt
ssh web1 ls -l /hello.txt
chef-run web1 file hello.txt content='Hello World!'
ssh web1 cat /hello.txt
chef-run web1 file hello.txt action=delete
ssh web1 cat /hello.txt

cat recipe.rb
chef-run web1 recipe.rb
ssh web1 cat /tmp/hello.txt

tree webserver
cat webserver/recipes/default.rb
cat webserver/templates/index.html.erb
chef-run web[1:2] webserver
curl web1
curl web2

cat loadbalancer/recipes/default.rb
cat loadbalancer/templates/haproxy.cfg.erb
chef-run lb loadbalancer
curl lb
curl lb

exit
docker-compose down
