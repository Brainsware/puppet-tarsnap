# == Class: tarsnap::params
#
# params class providing defaults for each supported operating system
#
class tarsnap::params {

  $keyfile = '/root/tarsnap.key'

  case $::kernel {
    'Linux': {
      $package_name = 'tarsnap'
      $prefix       = '/usr/local'
      $path         = '/usr/bin/tarsnap'
      $archive_path = "${prefix}/bin/tarsnap-archive"
      $rotate_path  = "${prefix}/bin/tarsnap-rotate"
      $batch_path   = "${prefix}/bin/tarsnap-batch"
      $configfile   = '/etc/tarsnap.conf'
      $cachedir     = '/var/backups/tarsnap'
      $user         = 'root'
      $group        = 'root'
    }
    'FreeBSD': {
      $package_name = 'tarsnap'
      $prefix       = '/usr/local'
      $path         = "${prefix}/bin/tarsnap"
      $archive_path = "${prefix}/bin/tarsnap-archive"
      $rotate_path  = "${prefix}/bin/tarsnap-rotate"
      $batch_path   = "${prefix}/bin/tarsnap-batch"
      $configfile   = "${prefix}/etc/tarsnap.conf"
      $cachedir     = "${prefix}/tarsnap-cache"
      $user         = 'root'
      $group        = 'wheel'
    }
    default: {
      fail("Unsupported operating system: ${::kernel}")
    }
  }
}
