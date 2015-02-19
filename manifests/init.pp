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
# [*path*]
#   Path to tarsnap. (Default: `/usr/bin/tarsnap`)
#
# [*archive_path*]
#   Path to tarsnap-archive script. (Default: `/usr/local/bin/tarsnap-archive`)
#
# [*rotate_path*]
#   Path to tarsnap-rotate script. (Default: `/usr/local/bin/tarsnap-rotate`)
#
# [*configfile*]
#   Path to tarsnap's configuration file. (Default: `/etc/tarsnap.conf`)
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
  $package_name          = 'tarsnap',
  $package_ensure        = 'present',
  $path                  = '/usr/bin/tarsnap',
  $archive_path          = '/usr/local/bin/tarsnap-archive',
  $rotate_path           = '/usr/local/bin/tarsnap-rotate',
  $configfile            = '/etc/tarsnap.conf',
  $cachedir              = '/var/backups/tarsnap',
  $keyfile               = '/root/tarsnap.key',
  $nodump                = true,
  $print_stats           = true,
  $checkpoint_bytes      = '1G',
  $aggressive_networking = undef,
) {
  validate_absolute_path($path)
  validate_absolute_path($archive_path)
  validate_absolute_path($rotate_path)
  validate_absolute_path($configfile)
  validate_absolute_path($cachedir)
  validate_absolute_path($keyfile)

  validate_bool($nodump)
  validate_bool($print_stats)
  if $aggressive_networking {
    validate_bool($print_stats)
  }

  contain ::tarsnap::install
  contain ::tarsnap::config
}
