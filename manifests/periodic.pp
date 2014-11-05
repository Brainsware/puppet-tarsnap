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
# [*path*]
#   Path to tarsnap binaries. (Default: `/usr/local/bin/tarsnap`)
#
# [*keep*]
#   How many archives to keep. If this is set to `undef` no archives will be deleted. (Default: `30`)
#
# [*hour*]
#   Hour when to run. (Default: `1+fqdn_rand(6)`, i.e.: between 01:xx and 06:xx)
#
# [*minute*]
#   Minute when to run. (Default: `fqdn_rand(60)`, i.e.: between xx:00 and xx:59)
#
# [*offset*]
#   Offset (in hours) when to run the cleanup job. (Default: `1`)
#
define tarsnap::periodic (
  $dirs,
  $path   = '/usr/local/bin/tarsnap',
  $keep   = 30,
  $hour   = 1+fqdn_rand(6),
  $minute = fqdn_rand(60),
  $offset = 1,
) {

  $dir_string = join($dirs, ' ')

  cron { "tarsnap-${title}-create":
    command => "${path} -c -f ${title}.`date +%Y%m%d` ${dir_string}",
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
      command => "${path} --list-archives | grep ${title}. | sort -rn | tail -n +${keep} | xargs -n1 ${path} -d -f",
      user    => 'root',
      hour    => $hour + $offset,
      minute  => $minute,
    }
  }
}
