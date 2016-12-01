# == class tarsnap::batch
#
# this class serializes (rather than ineffectually randomize) tarsnap jobs
#
class tarsnap::batch (
  Boolean $enable    = true,
  Integer $keep      = 30,
          $hour      = fqdn_rand(6, $title),
          $minute    = fqdn_rand(60, $title),
  Optional[Tarsnap::Location] $locations = $tarsnap::locations,
) {

  $ensure = $enable ? {
    false   => 'absent',
    default => 'present',
  }

  file { $tarsnap::batch_path:
    ensure  => $ensure,
    mode    => '0755',
    content => epp("${module_name}/tarsnap-batch.epp"),
  }

  cron { 'tarsnap-batch':
    ensure  => $ensure,
    command => $tarsnap::batch_path,
    user    => $tarsnap::user,
    hour    => $hour,
    minute  => $minute,
  }
}
