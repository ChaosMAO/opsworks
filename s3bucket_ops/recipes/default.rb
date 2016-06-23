# Install the aws-sdk in order to download the zip from S3

Chef::Log.info("******Downloading a file from Amazon S3.******")
chef_gem "aws-sdk" do
  compile_time false
end

# Define that aws-sdk is required
require 'aws-sdk'
# Declare the s3 object as an S3 client
s3 = Aws::S3::Client.new(region:'us-east-1')

# Set bucket and object name
obj = s3.get_object(bucket:'testsdkcookbook', key:'redshift.json')

# Read content to variable
content = obj.body.read
Chef::Log.info(content)

# Log output (optional)

# Write the S3 content to file (in /tmp)
file '/tmp/redshift.json' do
  owner 'root'
  group 'root'
  mode '0755'
  content content
  action :create
end




