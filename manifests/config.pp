# == Class tarsnap::config
#
# This class is called from tarsnap
#
class tarsnap::config {

  file { $::tarsnap::cachedir:
    ensure => directory,
    owner  => $::tarsnap::user,
    group  => $::tarsnap::group,
    mode   => '0700',
  }

  file { $::tarsnap::configfile:
    ensure  => file,
    owner   => $::tarsnap::user,
    group   => $::tarsnap::group,
    mode    => '0644',
    content => template("${module_name}/tarsnap.conf.erb"),
  }

}
