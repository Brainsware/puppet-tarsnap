# == Class: tarsnap::params
#
# params class providing defaults for each supported operating system
#
class tarsnap::params {

  $package_ensure        = 'present'
  $keyfile               = '/root/tarsnap.key'
  $nodump                = true
  $print_stats           = true
  $checkpoint_bytes      = '1G'
  $aggressive_networking = undef

  case $::kernel {
    'Linux': {
      $package_name = 'tarsnap'
      $prefix       = '/usr/local'
      $path         = '/usr/bin/tarsnap'
      $archive_path = "${prefix}/bin/tarsnap-archive"
      $rotate_path  = "${prefix}/bin/tarsnap-rotate"
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
