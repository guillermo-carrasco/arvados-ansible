# Define cluster components. Requires ~4GB of memory
arvados_cluster = {
    :workbench => {
        :hostname => "workbench",
        :ipaddress => "10.10.10.2",
        :memory => 1024,
        :ansible_role => "workbench"
    },
    :compute => {
        :hostname => "compute",
        :ipaddress => "10.10.10.3",
        :memory => 1024,
        :ansible_role => "compute"
    },
    :keep => {
        :hostname => "keep",
        :ipaddress => "10.10.10.4",
        :memory => 512,
        :ansible_role => "keep"
    },
    :keepstore1 => {
        :hostname => "keepstore1",
        :ipaddress => "10.10.10.5",
        :memory => 512,
        :ansible_role => "keepstore"
    },
    :keepstore2 => {
        :hostname => "keepstore2",
        :ipaddress => "10.10.10.6",
        :memory => 512,
        :ansible_role => "keepstore"
    },
    :shell => {
        :hostname => "shell",
        :ipaddress => "10.10.10.7",
        :memory => 512,
        :ansible_role => "shell"
    },
    :sso => {
        :hostname => "sso",
        :ipaddress => "10.10.10.8",
        :memory => 512,
        :ansible_role => "shell"
    }
}

# Set up _very_ basic networking
$script = <<SCRIPT
echo "10.10.10.2    workbench" >> /etc/hosts
echo "10.10.10.3    compute" >> /etc/hosts
echo "10.10.10.4    keep" >> /etc/hosts
echo "10.10.10.5    keepstore1" >> /etc/hosts
echo "10.10.10.6    keepstore2" >> /etc/hosts
echo "10.10.10.7    shell" >> /etc/hosts
echo "10.10.10.8    sso" >> /etc/hosts
SCRIPT

Vagrant.configure("2") do |global_config|
    arvados_cluster.each_pair do |name, options|
        global_config.vm.define name do |config|
            #VM configurations
            config.vm.box_url = "puppetlabs/centos-6.6-64-puppet"
            config.vm.box = "puppetlabs/centos-6.6-64-puppet"
            config.vm.hostname = options[:hostname]
            config.vm.network :private_network, ip: options[:ipaddress]

            #VM specifications
            config.vm.provider :virtualbox do |v|
                v.customize ["modifyvm", :id, "--memory", options[:memory]]
            end

            #VM provisioning
            config.vm.provision :shell,
                :inline => $script

            # Ansible provision
            config.vm.provision "ansible" do |ansible|
                ansible.playbook = "arvados.yaml"
                ansible.inventory_path = "cluster-vm"
            end
        end
    end
end
