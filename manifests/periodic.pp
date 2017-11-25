# == Define: tarsnap::periodic
#
# wrapper around cron to create and (optionally) cleanup tarsnap archives
#
define tarsnap::periodic (
  Array[Stdlib::Absolutepath] $dirs,
  Enum[present, absent]    $ensure  = present,
  Array[Stdlib::Absolutepath] $exclude = [],
  # won't validate these, since they are passed directly to cron
  $keep     = 30,
  $hour     = fqdn_rand(24, $title),
  $minute   = fqdn_rand(60, $title),
  $month    = undef,
  $monthday = undef,
  $weekday  = undef,
  Integer $offset = 1,
) {


  $dir_string = $dirs.join(' ')
  $exc_string = $exclude.prefix('--exclude ').join(' ')

  cron { "tarsnap-${title}-create":
    ensure   => $ensure,
    command  => "${tarsnap::archive_path} ${title} ${exc_string} ${dir_string}",
    user     => $tarsnap::user,
    hour     => $hour,
    minute   => $minute,
    month    => $month,
    monthday => $monthday,
    weekday  => $weekday,
  }

  # what this does:
  #   grep for the title,
  #   sort them numerically, then get the everything but last n ($keep)
  #   delete each one of those we've found, separately.
  if $keep > 0 {
    $off_hour = (24 + ($hour + $offset)) % 24
    cron { "tarsnap-${title}-keep-${keep}":
      ensure  => absent,
    }
    cron { "tarsnap-${title}-keep":
      ensure   => $ensure,
      command  => "${tarsnap::rotate_path} ${title} ${keep}",
      user     => $tarsnap::user,
      hour     => $off_hour,
      minute   => $minute,
      month    => $month,
      monthday => $monthday,
      weekday  => $weekday,
    }
  }
}
