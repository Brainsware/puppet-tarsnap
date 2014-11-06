# == Class tarsnap::params
#
# This class is meant to be called from tarsnap
# It sets variables according to platform
#
class tarsnap::params {
  $package_name          = 'tarsnap'
  $package_ensure        = 'present'
  $path                  = '/usr/local/bin/tarsnap'
  $archive_path          = '/usr/local/bin/tarsnap-archive'
  $rotate_path           = '/usr/local/bin/tarsnap-rotate'
  $configfile            = '/usr/local/etc/tarsnap.conf'
  $cachedir              = '/var/backups/tarsnap'
  $keyfile               = '/root/tarsnap.key'
  $nodump                = true
  $print_stats           = true
  $checkpoint_bytes      = '1G'
  $aggressive_networking = undef
}
