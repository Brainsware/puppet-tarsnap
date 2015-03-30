#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with tarsnap](#setup)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

this module helps install and configure tarsnap.

**It does not, and cannot help you create keys for servers. You have to do that manually**

## Setup

The `tarsnap` module assumes that you have a package named `tarsnap` in your
package repositories. You can override this expectation by either chainging the
`$package_name`, or by setting it to `undef` if you have other means of
installing it.

### PPA

For Ubuntu, I have created a
[PPA](https://launchpad.net/~tarsnap/+archive/ubuntu/lts) which builds the
latest version of tarsnap for all Ubuntu LTS. If you're interested in helping
with that, you can also join that team on launchpad.

### Keys

In order for tarsnap to be fully functional, and thus for this module to be,
you must setup the key. Please follow the [instructions of the official
documentation](https://www.tarsnap.com/gettingstarted.html)

As I'd rather not be responsible for making your backups inaccessible through a
puppet hickup, keys are, as of yet, not created automatically (and thus cannot
be re-created automatically ;).


## Usage

To install tarsnap from the package all that is needed is:

```puppet
include tarsnap
```

We can change basic parameters such as the package name:

```puppet
class { 'tarsnap':
  package_name => 'acme-tarsnap',
}
```

if the configuration file or the root key are not in the default locations, we
can change those as well:

```puppet
class { 'tarsnap':
  configfile => '/usr/local/etc/tarsnap.conf',
  keyfile    => '/secure/tarsnap.key',
}
```

Many option that can be set in `tarsnap.conf` can be set through the base
class. The most important one is `$cachedir`. All `boolean` options (those that
can be prefaced with `no-` in `tarsnap.conf`) can be set to `true`/`false`.

```puppet
class { 'tarsnap':
  cachedir               => '/var/backups/tarsnap',
  aggressive_networking  => false,
}
```

n.b.: this module will guarantee that `$cachedir` exists as directory and is
`root`:`root` owned.

The easiest way to use tarsnap is from cron:

```puppet
cron { 'tarsnap-etc-daily':
  command => "/usr/bin/tarsnap -c -f etc.`date +%Y%m%d` /etc /usr/local/etc /opt/etc",
  user    => 'root',
  hour    => 2,
  minute  => fqdn_rand(60),
}
```

if we want to only keep the last 30 days, we can follow this up with:

```puppet
cron { 'dailiy-tarsnap-etc-trim-30':
  command => "/usr/bin/tarsnap --list-archives | grep 'etc\.' | sort -n | head -n +30 | xargs -n 1 /usr/bin/tarsnap -d -f"
  user    => 'root',
  hour    => 3,
  minute  => fqdn_rand(60),
}
```

We provide a convenience wrapper around those two expressions:

```puppet
tarsnap::periodic { 'etc':
  dirs => [ 'etc', '/usr/local/etc', '/opt/etc' ],
  hour => 3,
}
```

## Reference

### tarsnap

* `package_name`: Name of tarsnap package. If tarsnap is installed by other means, set this to `undef` (Default: `tarsnap`)
* `package_ensure`: Ensure tarsnap package is in this version, `absent`, `present` or `latest`. (Default: `present`)
* `configfile`: Path to tarsnap's configuration file. (Default: `/etc/tarsnap.conf`)
* `path`: Path to tarsnap. (Default: `/usr/bin/tarsnap`)
* `archive_path`: Path to tarsnap-archive script. (Default: `/usr/local/bin/tarsnap-archive`)
* `rotate_path`: Path to tarsnap-rotate script. (Default: `/usr/local/bin/tarsnap-rotate`)
* `cachedir`: Path to tarsnap's cachedir. This directory will be created by puppet. (Default: `/var/backups/tarsnap`)
* `keyfile`: Path to tarsnap's keyfile for this machine. (Default: `/root/tarsnap.key`)
* `nodump`: Honor the `nodump` file flag. (Default: `true`)
* `print_stats`: Print statistics when creating or deleting archives. (Default: `true`)
* `checkpoint_bytes`: Create a checkpoint once per X of uploaded data (Default: `1G`)
* `aggressive_networking`: Use multiple TCP connections when writing archives. (Default: `undef`)

### tarsnap::periodic

* `name`: base-name of this archive
* `ensure`: Ensure presence or absence of cron jobs. (Default: `present`)
* `dirs`: Array of dirs to backup (Default: `[]`)
* `keep`: How many archives to keep. If this is set to `undef` no archives will be deleted. (Default: `30`)
* `hour`: Hour when to run. (Default: `fqdn_rand(24, $title)`, i.e.: between 00:xx and 23:xx)
* `minute`: Minute when to run. (Default: `fqdn_rand(60, $title)`, i.e.: between xx:00 and xx:59)
* `offset`: Offset (in hours) when to run the cleanup job. (Default: `1`)

## Limitations

While it is possible to configure tarsnap on a per-user basis, tarsnap::config
currently is a class. If you think it's useful to change that, please contribute!

## Development

Please use the github issues functionality to report any bugs or requests for new features.
Feel free to fork and submit pull requests for potential contributions.
