#https://learn.chef.io/skills/joy-of-automating-episode-4/
# Cookbook Name:: jenkins
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
# wget -q -O - https://jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
# sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
# sudo apt-get update
# sudo apt-get install jenkins

remote_file '/tmp/jenkins-ci.org.key' do
  source 'https://jenkins-ci.org/debian/jenkins-ci.org.key'
  notifies :run,'execute[apt-key add /tmp/jenkins-ci.org.key]', :immediately
end

#sudo apt-key add 
execute 'apt-key add /tmp/jenkins-ci.org.key' do 
	action :nothing
end 

file '/etc/apt/sources.list.d/jenkins.list' do
  action :create
  content 'deb http://pkg.jenkins-ci.org/debian binary/'
  notifies :run, 'execute[apt-get update]' , :immediately
end

execute 'apt-get update' do 
	action :nothing 
end 

package 'openjdk-7-jdk' do 
	action :install 
end 

package 'openjdk-7-jre-headless' do 
	action :install
end 
#apt-get install
package 'jenkins' do
  action :install
end


