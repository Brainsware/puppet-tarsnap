# == Class tarsnap::config
#
# This class is called from tarsnap
#
class tarsnap::config {

  file { $::tarsnap::cachedir:
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0700',
  }

  file { $::tarsnap::configfile:
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("${module_name}/tarsnap.conf.erb"),
  }

}
