# == Class tarsnap::params
#
# This class is meant to be called from tarsnap
# It sets variables according to platform
#
class tarsnap::params {
  $package_name          = 'tarsnap'
  $package_ensure        = 'present'
  $configfile            = '/etc/tarsnap.conf'
  $cachedir              = '/var/backups/tarsnap'
  $keyfile               = '/root/tarsnap.key'
  $nodump                = true
  $print_stats           = true
  $checkpoint_bytes      = '1G'
  $aggressive_networking = undef
}
