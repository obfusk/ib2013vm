cfg = {
  :priv_key => './id_rsa',
  :shares   => { 'shared' => '/home/vagrant/shared' }
  :custom   => ['modifyvm', :id, '--memory', 512],
}

require 'fileutils'
require 'tmpdir'

cfg[:shares].each { |k,v| FileUtils.mkdir_p k }

box = 'ib2013vm'

f = lambda do |config|
  config.vm.box = box
  if ENV['OLD_KEY'] != 'yes'
    config.ssh.private_key_path = cfg[:priv_key]
  end
  config.ssh.forward_x11 = true
  config.vm.provision :shell, :path => 'provision.sh'
end

Dir.mktmpdir do |tdir|

  if Vagrant::VERSION =~ /^1\.0\./
    Vagrant::Config.run do |config|
      f[config]
      config.vm.customize cfg[:custom]
      config.vm.share_folder 'v-root', '/.vagrant-shared',
        "#{tdir}/.shared", :create => true
      cfg[:shares].each do |k,v|
        config.vm.share_folder k, v, k, :create => true
      end
    end
  else
    Vagrant::Config.run('2') do |config|
      f[config]
      config.vm.provider :virtualbox do |vb|
        vb.customize cfg[:custom]
      end
      config.vm.synced_folder '.', '/vagrant', :disabled => true
      cfg[:shares].each do |k,v|
        config.vm.synced_folder k, v, :create => true
      end
    end
  end

end
