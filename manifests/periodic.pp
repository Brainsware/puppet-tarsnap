# == Define: tarsnap::periodic
#
# wrapper around cron to create and (optionally) cleanup tarsnap archives
#
# === Parameters
#
# [*name*]
#   base-name of this archive
#
# [*dirs*]
#   Array of dirs to backup
#
# [*keep*]
#   How many archives to keep. If this is set to `undef` no archives will be deleted. (Default: `30`)
#
# [*hour*]
#   Hour when to run. (Default: `fqdn_rand(24, $title)`, i.e.: between 0:xx and 23:xx)
#
# [*minute*]
#   Minute when to run. (Default: `fqdn_rand(60, $title)`, i.e.: between xx:00 and xx:59)
#
# [*offset*]
#   Offset (in hours) when to run the cleanup job. (Default: `1`)
#
define tarsnap::periodic (
  $dirs,
  $keep   = 30,
  $hour   = fqdn_rand(24, $title),
  $minute = fqdn_rand(60, $title),
  $offset = 1,
) {

  $dir_string = join($dirs, ' ')

  cron { "tarsnap-${title}-create":
    command => "${::tarsnap::archive_path} ${title} ${dir_string}",
    user    => 'root',
    hour    => $hour,
    minute  => $minute,
  }

  # what this does:
  #   grep for the title,
  #   sort them numerically, then get the everything but last n ($keep)
  #   delete each one of those we've found, separately.
  if $keep {
    cron { "tarsnap-${title}-keep-${keep}":
      command => "${::tarsnap::rotate_path} ${title} ${keep}",
      user    => 'root',
      hour    => $hour + $offset,
      minute  => $minute,
    }
  }
}
