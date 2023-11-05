# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'getoptlong'

# Parse CLI arguments.
opts = GetoptLong.new(
  [ '--provider',     GetoptLong::OPTIONAL_ARGUMENT ],
)

provider='virtualbox'
begin
  opts.each do |opt, arg|
    case opt
      when '--provider'
        provider=arg
    end # case
  end # each
  rescue
end

Vagrant.configure("2") do |config|

  config.vm.define :debianbookworm1, primary: true do |debianbookworm1|
    debianbookworm1.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "1024", "--cpus", "1"]
    end
    debianbookworm1.vm.provider :libvirt do |lv|
      lv.memory = 1024
      lv.cpus = 1
    end
    debianbookworm1.vm.box = "debian/bookworm64"
    debianbookworm1.vm.hostname = "debianbookworm1"
    debianbookworm1.vm.network :private_network, ip: "192.168.56.11"
    debianbookworm1.vm.provision "shell", inline: <<-SHELL
      apt update
      apt upgrade -y
      apt install -qy git systemd-timesyncd curl gnupg2
      curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | gpg --no-default-keyring --keyring gnupg-ring:/usr/share/keyrings/wazuh.gpg --import && chmod 644 /usr/share/keyrings/wazuh.gpg
      echo "deb [signed-by=/usr/share/keyrings/wazuh.gpg] https://packages.wazuh.com/4.x/apt/ stable main" | tee -a /etc/apt/sources.list.d/wazuh.list
      apt update
      apt upgrade -y
      git clone https://github.com/rene-serral/monitoring-course.git ~vagrant/Scripts
      chown vagrant:vagrant -R ~vagrant/Scripts
      WAZUH_MANAGER="192.168.56.10" apt-get -y install wazuh-agent
      systemctl daemon-reload
      systemctl enable wazuh-agent
      systemctl start wazuh-agent
      SHELL
  end

  config.vm.define :debianbookworm2, primary: true do |debianbookworm2|
    debianbookworm2.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "1024", "--cpus", "1"]
    end
    debianbookworm2.vm.provider :libvirt do |lv|
      lv.memory = 1024
      lv.cpus = 1
    end
    debianbookworm2.vm.box = "debian/bookworm64"
    debianbookworm2.vm.hostname = "debianbookworm2"
    debianbookworm2.vm.network :private_network, ip: "192.168.56.12"
    debianbookworm2.vm.provision "shell", inline: <<-SHELL
      apt update
      apt upgrade -y
      apt install -qy git systemd-timesyncd curl gnupg2
      curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | gpg --no-default-keyring --keyring gnupg-ring:/usr/share/keyrings/wazuh.gpg --import && chmod 644 /usr/share/keyrings/wazuh.gpg
      echo "deb [signed-by=/usr/share/keyrings/wazuh.gpg] https://packages.wazuh.com/4.x/apt/ stable main" | tee -a /etc/apt/sources.list.d/wazuh.list
      apt update
      apt upgrade -y
      git clone https://github.com/rene-serral/monitoring-course.git ~vagrant/Scripts
      chown vagrant:vagrant -R ~vagrant/Scripts
      WAZUH_MANAGER="192.168.56.10" apt-get -y install wazuh-agent
      systemctl daemon-reload
      systemctl enable wazuh-agent
      systemctl start wazuh-agent
      SHELL
  end

  config.vm.define :wazuh do |wazuh|
    wazuh.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "4096", "--cpus", "2"]
    end
    wazuh.vm.provider :libvirt do |lv|
      lv.memory = 4096
      lv.cpus = 2
    end

    wazuh.vm.hostname = "wazuh"
    wazuh.vm.network :private_network, ip: "192.168.56.10"
    wazuh.vm.box = "debian/bookworm64"
    wazuh.vm.provision "shell", inline: <<-SHELL
      apt update
      apt -y upgrade
      apt install wget curl
      curl -sO https://packages.wazuh.com/4.6/wazuh-install.sh
      wget -O- https://packages.wazuh.com/4.6/config.yml | sed s/\"\<indexer-node-ip\>\"/192.168.56.10/g \
        | sed s/\"\<wazuh-manager-ip\>\"/192.168.56.10/g \
        | sed s/\"\<dashboard-node-ip\>\"/192.168.56.10/g > config.yml
      bash wazuh-install.sh -i --generate-config-files
      bash wazuh-install.sh -i --wazuh-indexer node-1
      bash wazuh-install.sh -i --start-cluster
      bash wazuh-install.sh -i --wazuh-server wazuh-1
      bash wazuh-install.sh -i --wazuh-dashboard dashboard
      echo "Here you have the generated credentials"
      tar -O -xvf wazuh-install-files.tar wazuh-install-files/wazuh-passwords.txt
      SHELL
  end

  config.vm.define :windows10 do |windows10|
    windows10.vm.provider :virtualbox do |vb|
      vb.customize ['modifyvm', :id, '--usb', 'on']
      vb.customize ["modifyvm", :id, "--usbehci", "on"]
      vb.customize ["modifyvm", :id, "--memory", "2048", "--cpus", "2"]
    end
    windows10.vm.provider :libvirt do |lv|
      lv.memory = 2048
      lv.cpus = 2
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
    windows2022.vm.provider :libvirt do |lv|
      lv.memory = 2048
      lv.cpus = 2
    end
    windows2022.vm.hostname = "windows"
    windows2022.vm.network :private_network, ip: "192.168.56.20"
    windows2022.vm.box = "peru/windows-server-2022-standard-x64-eval"
    #windows2022.vm.box_version = "20210907.01"
    windows2022.vm.provision "shell", path: "https://raw.githubusercontent.com/rene-serral/monitoring-course/main/Modulo-2/Configure-base.bat"
  end

  config.vm.define :ossim do |ossim|
    ossim.vm.box = "ifly53e/av_5.7.4"
    ossim.vm.network :private_network, ip: "192.168.56.200"
  end

  config.vm.define :splunk do |splunk|
    splunk.vm.box = "cybersecurity/splunk"
    splunk.vm.box_version = "0.0.1"
    splunk.vm.network :private_network, ip: "192.168.56.13"
  end
end
