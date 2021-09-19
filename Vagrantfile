# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "4096", "--cpus", "2"]
    vb.customize ["storageattach", :id, 
                "--storagectl", "IDE Controller", 
                "--port", "0", "--device", "1", 
                "--type", "dvddrive", 
                "--medium", "emptydrive"] 
   end

  config.vm.define :grafana, primary: true do |grafana|
    grafana.vm.box = "debian/bullseye64"
    grafana.vm.hostname = "grafana"
    grafana.vm.network :private_network, ip: "192.168.55.11"
    grafana.vm.provision "shell", inline: <<-SHELL
      apt update
      apt install -y gnupg2
      wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
      echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-7.x.list
      sudo apt-get update && sudo apt-get install -y elasticsearch
      systemctl daemon-reload
      systemctl enable elasticsearch.service
      systemctl start elasticsearch.service
      wget -qO- https://repos.influxdata.com/influxdb.key | gpg --dearmor > /etc/apt/trusted.gpg.d/influxdb.gpg
      export DISTRIB_ID=$(lsb_release -si); export DISTRIB_CODENAME=$(lsb_release -sc)
      echo "deb [signed-by=/etc/apt/trusted.gpg.d/influxdb.gpg] https://repos.influxdata.com/${DISTRIB_ID,,} ${DISTRIB_CODENAME} stable" > /etc/apt/sources.list.d/influxdb.list
      sudo apt-get update && sudo apt-get install -y influxdb
      systemctl unmask influxdb.service
      systemctl start influxdb
      wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -
      echo "deb https://packages.grafana.com/enterprise/deb stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
      apt update
      apt install -y grafana-enterprise
      systemctl enable grafana-server
      systemctl start grafana-server
    SHELL
  end


  config.vm.define :wazuh do |wazuh|
    wazuh.vm.hostname = "wazuh"
    wazuh.vm.network :private_network, ip: "192.168.55.10"
    wazuh.vm.box = "uahccre/wazuh-manager"
  end

  config.vm.define :windows10 do |windows10|
    windows10.vm.hostname = "windows10"
    windows10.vm.network :private_network, ip: "192.168.55.21"
    windows10.vm.box = "peru/windows-10-enterprise-x64-eval"
    windows10.vm.provision "shell", path: "https://raw.githubusercontent.com/rene-serral/monitoring-course/main/Configure-base.bat"
  end

  config.vm.define :windows do |windows|
    windows.vm.hostname = "windows"
    windows.vm.network :private_network, ip: "192.168.55.20"
    windows.vm.box = "peru/windows-server-2022-standard-x64-eval"
    windows.vm.box_version = "20210907.01"
  end

end
