#
# Cookbook Name:: rotate-log-to-s3
# Recipe:: default
#
# Copyright 2014, hassaku
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# install aws-cli
package "python-devel" do
  action :install
end

package "python-pip" do
  action :install
end

bash "install awscli" do
  user 'root'
  group 'root'
  code "pip install awscli==1.3.0"
end

# logrotate configuration including upload to S3
if node['rotate-log-to-s3']
  node['rotate-log-to-s3'].each do |name, options|
    template "logrotate-#{name}" do
      path "/etc/logrotate.d/#{name}"
      source 'logrotate.erb'
      owner 'root'
      group 'root'
      mode '0644'
      variables({ :options => options })
    end
  end
end
