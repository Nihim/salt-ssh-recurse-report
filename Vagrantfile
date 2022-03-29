SALT_SSH       = "172.16.9.10"
SALT_TARGET    = "172.16.9.11"


Vagrant.configure("2") do |config|
  config.ssh.insert_key = true
  config.vm.box = "ubuntu/focal64"
  config.vm.synced_folder "vagrant_share/", "/vagrant"

  boxes = [
    { :name => "salt-ssh",    :ip => SALT_SSH,    :cpus => 1, :memory => 1024 },
    { :name => "salt-target", :ip => SALT_TARGET, :cpus => 1, :memory => 1024 },
  ]

  boxes.each do |opts|
    config.vm.define opts[:name] do |box|
      box.vm.hostname = opts[:name]
      box.vm.network :private_network, ip: opts[:ip]

      box.vm.provider "virtualbox" do |vb|
        vb.cpus = opts[:cpus]
        vb.memory = opts[:memory]
        vb.name = opts[:name]
        vb.customize ["modifyvm", :id, "--vram", "16"]
        vb.customize ["modifyvm", :id, "--graphicscontroller", "vmsvga"]
        vb.customize ["modifyvm", :id, "--vrde", "off"]
      end

      if box.vm.hostname == "salt-ssh" then
          box.vm.provision "shell", inline:'apt update && apt install -y python3-pip openssh-client nvi && echo "172.16.9.11 salt-target" >> /etc/hosts && su - vagrant -c "python3 -m pip install --user jinja2==3.0.3 salt-ssh && ssh-keygen -t ed25519 -N \"\" -q -f ~/.ssh/id_ed25519 && cp ~/.ssh/id_ed25519.pub /vagrant/"'
      else
          box.vm.provision "shell", inline:'cat /vagrant/id_ed25519.pub >> ~vagrant/.ssh/authorized_keys && rm -f /vagrant/id_ed25519.pub'
      end

    end
  end
end
