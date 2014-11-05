# == Class: tarsnap
#
# main class driving installation and configuration of tarsnap
#
# === Parameters
#
# [*package_name*]
#   Name of tarsnap package. If tarsnap is installed by other means, set this to `undef` (Default: `tarsnap`)
#
# [*package_ensure*]
#   Ensure tarsnap package is in this version, `absent`, `present` or `latest`. (Default: `present`)
#
# [*configfile*]
#   Path to tarsnap's configuration file. (Default: `/usr/local/etc/tarsnap.conf`)
#
# [*cachedir*]
#   Path to tarsnap's cachedir. This directory will be created by puppet. (Default: `/var/backups/tarsnap`)
#
# [*keyfile*]
#   Path to tarsnap's keyfile for this machine. (Default: `/root/tarsnap.key`)
#
# [*nodump*]
#   Honor the `nodump` file flag. (Default: `true`)
#
# [*print_stats*]
#   Print statistics when creating or deleting archives. (Default: `true`)
#
# [*checkpoint_bytes*]
#   Create a checkpoint once per X of uploaded data (Default: `1G`)
#
# [*aggressive_networking*]
#   Use multiple TCP connections when writing archives. (Default: `undef`)
#
class tarsnap (
  $package_name          = $::tarsnap::params::package_name,
  $package_ensure        = $::tarsnap::params::service_name,
  $configfile            = $::tarsnap::params::configfile,
  $cachedir              = $::tarsnap::params::cachedir,
  $keyfile               = $::tarsnap::params::keyfile,
  $nodump                = $::tarsnap::params::nodump,
  $print_stats           = $::tarsnap::params::print_stats,
  $checkpoint_bytes      = $::tarsnap::params::checkpoint_bytes,
  $aggressive_networking = $::tarsnap::params::aggressive_networking,
) inherits ::tarsnap::params {

  # validate parameters here

  contain ::tarsnap::install
  contain ::tarsnap::config
}
