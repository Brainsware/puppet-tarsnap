# == Class: tarsnap
#
# main class driving installation and configuration of tarsnap
#
# === Parameters
#
class tarsnap (
  String $package_name,
  Tea::Absolutepath $path,
  Tea::Absolutepath $archive_path,
  Tea::Absolutepath $rotate_path,
  Tea::Absolutepath $batch_path,
  Tea::Absolutepath $configfile,
  Tea::Absolutepath $cachedir,
  String $user,
  String $group,
  String $package_ensure        = 'present',
  Tea::Absolutepath $keyfile    = '/root/tarsnap.key',
  # config
  Boolean           $nodump                = true,
  Boolean           $print_stats           = true,
  String            $checkpoint_bytes      = '1G',
  Optional[Boolean] $aggressive_networking = undef,
  # batch
  Boolean           $batch_enable          = false,
  Tarsnap::Location $locations             = {},
) {

  contain tarsnap::install
  contain tarsnap::config

  Class[tarsnap::install] ~> Class[tarsnap::config]

  class { 'tarsnap::batch':
    enable    => $batch_enable,
    locations => $locations,
  }
}
