#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with tarsnap](#setup)
    * [Setup requirements](#setup-requirements)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

this module helps install and configure tarsnap.

**It does not, and cannot help you create keys for servers. You have to do that manually**

What it can do however, is manage archives. It does so with the native puppet type, `tarsnap_archive`

## Setup

The `tarsnap` module assumes that you have a package named `tarsnap` in your
package repositories. You can override this expectation by either chainging the
`$package_name`, or by setting it to `undef` if you have other means of
installing it.

In order for tarsnap to be fully functional, and thus for this module to be,
you must setup the key. Please follow the [instructions of the official
documentation](https://www.tarsnap.com/gettingstarted.html)

### Setup Requirements **OPTIONAL**

Since this module provides a native type, pluginsync must be enabled.

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

Every option that can be set in `tarsnap.conf` can be set through the base
class. The most important one is `$cachedir`. All `boolean` options (those that
can be prefaced with `no-` in `tarsnap.conf`) can be set to `true`/`false`.

```puppet
class { 'tarsnap':
  cachedir               => '/var/backup/tarsnap',
  aggressive_networking  => false,
}
```

n.b.: this module will guarantee that `$cachedir` exists as directory and is
`root`:`root` owned.

## Reference

Here, list the classes, types, providers, facts, etc contained in your module. This section should include all of the under-the-hood workings of your module so people know what the module is touching on their system but don't need to mess with things. (We are working on automating this section!)

## Limitations

This is where you list OS compatibility, version compatibility, etc.

## Development

Since your module is awesome, other users will want to play with it. Let them know what the ground rules for contributing are.

## Release Notes/Contributors/Etc **Optional**

If you aren't using changelog, put your release notes here (though you should consider using changelog). You may also add any additional sections you feel are necessary or important to include here. Please use the `## ` header. 
