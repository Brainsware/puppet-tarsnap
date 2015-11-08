# == class tarsnap::batch
#
# this class serializes (rather than ineffectually randomize) tarsnap jobs
#
class tarsnap::batch (
  $ensure    = present,
  $keep      = 30,
  $hour      = fqdn_rand(6, $title),
  $minute    = fqdn_rand(60, $title),
  $locations = $::tarsnap::locations,
) {

  validate_re($ensure, '^(present|absent)$')

  $file_ensure = $ensure ? {
    'present' => 'file',
    default   => $ensure,
  }

  file { $::tarsnap::batch_path:
    ensure  => $file_ensure,
    mode    => '0755',
    content => template("${module_name}/tarsnap-batch.erb"),
  }

  cron { 'tarsnap-batch':
    ensure  => $ensure,
    command => $::tarsnap::batch_path,
    user    => $::tarsnap::user,
    hour    => $hour,
    minute  => $minute,
  }
}
