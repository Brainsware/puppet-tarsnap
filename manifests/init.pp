# == Class: tarsnap
#
# main class driving installation and configuration of tarsnap
#
# === Parameters
#
class tarsnap (
  $package_name          = $::tarsnap::params::package_name,
  $package_ensure        = $::tarsnap::params::package_ensure,
  $path                  = $::tarsnap::params::path,
  $archive_path          = $::tarsnap::params::archive_path,
  $rotate_path           = $::tarsnap::params::rotate_path,
  $batch_path            = $::tarsnap::params::batch_path,
  $configfile            = $::tarsnap::params::configfile,
  $cachedir              = $::tarsnap::params::cachedir,
  $keyfile               = $::tarsnap::params::keyfile,
  $nodump                = $::tarsnap::params::nodump,
  $print_stats           = $::tarsnap::params::print_stats,
  $checkpoint_bytes      = $::tarsnap::params::checkpoint_bytes,
  $aggressive_networking = $::tarsnap::params::aggressive_networking,
  $user                  = $::tarsnap::params::user,
  $group                 = $::tarsnap::params::group,
  # batch
  $locations             = {},
) inherits ::tarsnap::params {

  validate_absolute_path($path)
  validate_absolute_path($archive_path)
  validate_absolute_path($rotate_path)
  validate_absolute_path($batch_path)
  validate_absolute_path($configfile)
  validate_absolute_path($cachedir)
  validate_absolute_path($keyfile)

  validate_bool($nodump)
  validate_bool($print_stats)

  if $aggressive_networking {
    validate_bool($print_stats)
  }

  class { '::tarsnap::install': } ~>
  class { '::tarsnap::config': }

  unless empty($locations) {
    include ::tarsnap::batch
  }
}
