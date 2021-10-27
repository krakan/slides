file '/tmp/whoami' do
  content "filen ligger pa " + node['hostname'] + "\n"
end
