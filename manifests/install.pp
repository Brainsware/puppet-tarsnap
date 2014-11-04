# == Class tarsnap::install
#
class tarsnap::install {

  package { $::tarsnap::package_name:
    ensure => $::tarsnap::package_ensure,
  }
}
