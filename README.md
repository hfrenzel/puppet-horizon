Team and repository tags
========================

[![Team and repository tags](https://governance.openstack.org/tc/badges/puppet-horizon.svg)](https://governance.openstack.org/tc/reference/tags/index.html)

<!-- Change things from this point on -->

horizon
=======

#### Table of Contents

1. [Overview - What is the horizon module?](#overview)
2. [Module Description - What does the module do?](#module-description)
3. [Setup - The basics of getting started with horizon](#setup)
4. [Implementation - An under-the-hood peek at what the module is doing](#implementation)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Beaker-Rspec - Beaker-rspec tests for the project](#beaker-rpsec)
7. [Development - Guide for contributing to the module](#development)
8. [Release Notes - Release notes for the project](#release-notes)
9. [Contributors - Those with commits](#contributors)
10. [Repository - The project source code repository](#repository)

Overview
--------

The horizon module is a part of [OpenStack](https://opendev.org/openstack), an effort by the OpenStack infrastructure team to provide continuous integration testing and code review for OpenStack and OpenStack community projects as part of the core software.  The module its self is used to flexibly configure and manage the dashboard service for OpenStack.

Module Description
------------------

The horizon module is a thorough attempt to make Puppet capable of managing the entirety of horizon.  Horizon is a fairly classic django application, which results in a fairly simply Puppet module.

This module is tested in combination with other modules needed to build and leverage an entire OpenStack software stack.

Setup
-----

**What the horizon module affects**

* [Horizon](https://docs.openstack.org/horizon/latest/), the dashboard service for OpenStack.

### Installing horizon

    puppet module install openstack/horizon

### Beginning with horizon

To utilize the horizon module's functionality you will need to declare multiple resources but you'll find that doing so is much less complicated than the other OpenStack component modules. We recommend you consult and understand the [core openstack](http://docs.openstack.org) documentation.

**Define a horizon dashboard**

```puppet
class { 'memcached':
  listen_ip => '127.0.0.1',
  tcp_port  => '11211',
  udp_port  => '11211',
}

class { '::horizon':
  cache_server_ip       => '127.0.0.1',
  cache_server_port     => '11211',
  secret_key            => '12345',
  django_debug          => 'True',
  api_result_limit      => '2000',
}
```

Implementation
--------------

### horizon

Horizon is a simple module using the combination of a package, template, and the file_line type.  Most all the configuration lives inside the included local_settings template and the file_line type is for selectively inserting needed lines into configuration files that aren't explicitly managed by the horizon module.

Limitations
-----------

* Only supports Apache using mod_wsgi.

Beaker-Rspec
------------

This module has beaker-rspec tests

To run:

```shell
bundle install
bundle exec rspec spec/acceptance
```

Development
-----------

Developer documentation for the entire puppet-openstack project.

* https://docs.openstack.org/puppet-openstack-guide/latest/

Release Notes
-------------

* https://docs.openstack.org/releasenotes/puppet-horizon

Contributors
------------

* https://github.com/openstack/puppet-horizon/graphs/contributors

Repository
----------

* https://opendev.org/openstack/puppet-horizon
