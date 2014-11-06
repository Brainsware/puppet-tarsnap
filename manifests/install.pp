# == Class tarsnap::install
#
class tarsnap::install {

  package { $::tarsnap::package_name:
    ensure => $::tarsnap::package_ensure,
  }

  file { $::tarsnap::archive_path:
    ensure  => present,
    mode    => '0755',
    content => template("${module_name}/tarsnap-archive.erb"),
  }
  file { $::tarsnap::rotate_path:
    ensure  => present,
    mode    => '0755',
    content => template("${module_name}/tarsnap-rotate.erb"),
  }
}
