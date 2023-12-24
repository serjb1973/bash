# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
config.vm.box = "centos/7"
config.vm.box_version = "2004.01"
config.vm.provider "virtualbox" do |v|
v.memory = 256
v.cpus = 1
end
config.vm.define "bash" do |srv|
srv.vm.network "private_network", ip: "192.168.56.30",
virtualbox__intnet: "net1"
srv.vm.hostname = "bash"
end
end
