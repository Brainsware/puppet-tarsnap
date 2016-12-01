# == Class tarsnap::install
#
class tarsnap::install {

  package { 'tarsnap':
    ensure => $tarsnap::package_ensure,
    name   => $tarsnap::package_name,
  }

  file { $tarsnap::archive_path:
    ensure  => file,
    mode    => '0755',
    content => epp("${module_name}/tarsnap-archive.epp"),
  }
  file { $tarsnap::rotate_path:
    ensure  => file,
    mode    => '0755',
    content => epp("${module_name}/tarsnap-rotate.epp"),
  }
}
