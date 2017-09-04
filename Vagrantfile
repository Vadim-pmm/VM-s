# -*- mode: ruby -*-
# vi: set ft=ruby :

$script = <<SCRIPT
	sudo apt-get -y update > /dev/null 2>&1
	RUBY_VERSION='2.4.0'
	
	sudo apt-get update -qq > /dev/null 2>&1
	sudo apt-get install -y build-essential libpq-dev > /dev/null 2>&1
	sudo apt-get install -y libreadline-dev > /dev/null 2>&1
	sudo apt-get install -y libssl-dev > /dev/null 2>&1

	echo "-- Installing git and build tools ..."
	sudo apt-get install -y git

	echo "-- Installing Ruby ..."
	sudo git clone https://github.com/sstephenson/ruby-build.git /usr/local/ruby-build
	sudo bash /usr/local/ruby-build/install.sh

	sudo bash /usr/local/bin/ruby-build $RUBY_VERSION /home/rubies/$RUBY_VERSION
	echo export PATH="/home/rubies/$RUBY_VERSION/bin:$PATH" >> ~/.bashrc

	echo "-- Installing postgresql ..."
	sudo locale-gen en_US.UTF-8 && sudo update-locale LC_ALL=en_US.UTF-8

	sudo sh -c "echo 'deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main' >> /etc/apt/sources.list.d/pgdg.list"
	wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -
	sudo apt-get update > /dev/null 2>&1
	sudo apt-get install -y postgresql-common libpq-dev postgresql-9.5 > /dev/null 2>&1

SCRIPT

Vagrant.configure("2") do |config|

  # Vagrant forcibly installs Ruby by default in /opt/vagrant_ruby/bin

  config.vm.box = "hashicorp/precise64"
  config.vm.box_check_update = false
  config.vm.network "forwarded_port", guest: 3000, host: 3000


  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
  end
 
  config.vm.provision :shell, privileged: false, inline: $script

end
