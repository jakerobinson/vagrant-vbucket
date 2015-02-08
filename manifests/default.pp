class { 'nginx': }

nginx::resource::upstream { 'vbucket':
  members => [
    'localhost:8080'
  ],
}

nginx::resource::vhost { 'localhost':
  proxy => 'http://vbucket',
}

firewall { '100 allow http':
  port   => 80,
  proto  => tcp,
  action => accept,
}

package { 'git': ensure => installed }
exec { 'github_ssh': command => '/usr/bin/ssh-keygen -r github.com' }

file { '/home/vagrant/.ssh/id_rsa':
  ensure  => file,
  force   => true,
  source  => '/vagrant/vbucket_deploy',
  owner   => 'vagrant',
}

vcsrepo { "/home/vagrant/vbucket":
  ensure   => present,
  provider => git,
  source   => "git@github.com:jakerobinson/vbucket.git",
  require  => [Package['git'], Exec['github_ssh'], File['/home/vagrant/.ssh/id_rsa']],
  user     => 'vagrant',
}
