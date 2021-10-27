group 'mygroup'

user 'myuser' do
  group 'mygroup'
end

file '/tmp/myfile' do
  owner 'myuser'
  group 'mygroup'
  mode '0444'
end
