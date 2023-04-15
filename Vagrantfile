# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|

  config.vm.define :debianbullseye1, primary: true do |debianbullseye1|
    debianbullseye1.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "1024", "--cpus", "1"]
    end
    debianbullseye1.vm.box = "debian/bullseye64"
    debianbullseye1.vm.hostname = "debianbullseye1"
    debianbullseye1.vm.network :private_network, ip: "192.168.56.11"
    debianbullseye1.vm.provision "shell", inline: <<-SHELL
      apt update
      apt upgrade -y
      apt install -qy git systemd-timesyncd curl gnupg2
      git clone https://github.com/rene-serral/monitoring-course.git ~vagrant/Scripts
      chown vagrant.vagrant -R ~vagrant/Scripts
      systemctl daemon-reload
      systemctl enable wazuh-agent
      systemctl start wazuh-agent
      SHELL
  end

  config.vm.define :debianbullseye2, primary: true do |debianbullseye2|
    debianbullseye2.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "1024", "--cpus", "1"]
    end
    debianbullseye2.vm.box = "debian/bullseye64"
    debianbullseye2.vm.hostname = "debianbullseye2"
    debianbullseye2.vm.network :private_network, ip: "192.168.56.12"
    debianbullseye2.vm.provision "shell", inline: <<-SHELL
      apt update
      apt upgrade -y
      apt install -qy git systemd-timesyncd curl gnupg2
      git clone https://github.com/rene-serral/monitoring-course.git ~vagrant/Scripts
      chown vagrant.vagrant -R ~vagrant/Scripts
      systemctl daemon-reload
      systemctl enable wazuh-agent
      systemctl start wazuh-agent
      SHELL
  end

  config.vm.define :wazuh do |wazuh|
    wazuh.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "4096", "--cpus", "2"]
      vb.customize ["storageattach", :id, 
                  "--storagectl", "IDE", 
                  "--port", "0", "--device", "1", 
                  "--type", "dvddrive", 
                  "--medium", "emptydrive"] 
    end

    wazuh.vm.hostname = "wazuh"
    wazuh.vm.network :private_network, ip: "192.168.56.10"
    wazuh.vm.box = "uahccre/wazuh-manager"
    wazuh.vm.provision "shell", inline: <<-SHELL
      chown -R elasticsearch.elasticsearch /var/run/elasticsearch
      SHELL
  end

  config.vm.define :windows10 do |windows10|
    windows10.vm.provider :virtualbox do |vb|
      vb.customize ['modifyvm', :id, '--usb', 'on']
      vb.customize ["modifyvm", :id, "--usbehci", "on"]
      vb.customize ["modifyvm", :id, "--memory", "2048", "--cpus", "2"]
    end
    windows10.vm.hostname = "windows10"
    windows10.vm.network :private_network, ip: "192.168.56.21"
    windows10.vm.box = "peru/windows-10-enterprise-x64-eval"
    windows10.vm.provision "shell", path: "https://raw.githubusercontent.com/rene-serral/monitoring-course/main/Modulo-2/Configure-base.bat"
  end

  config.vm.define :windows2022 do |windows2022|
    windows2022.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "2048", "--cpus", "2"]
    end
    windows2022.vm.hostname = "windows"
    windows2022.vm.network :private_network, ip: "192.168.56.20"
    windows2022.vm.box = "peru/windows-server-2022-standard-x64-eval"
    #windows2022.vm.box_version = "20210907.01"
    windows2022.vm.provision "shell", path: "https://raw.githubusercontent.com/rene-serral/monitoring-course/main/Modulo-2/Configure-base.bat"
  end

  config.vm.define :ossim do |ossim|
    ossim.vm.box = "ifly53e/av_5.7.4"
    ossim.vm.box_version = "0.0.1"
    ossim.vm.network :private_network, ip: "192.168.56.200"
  end

  config.vm.define :splunk do |splunk|
    splunk.vm.box = "cybersecurity/splunk"
    splunk.vm.box_version = "0.0.1"
    splunk.vm.network :private_network, ip: "192.168.56.13"
  end

end
