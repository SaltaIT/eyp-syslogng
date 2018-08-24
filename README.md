# syslogng

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with syslogng](#setup)
    * [What syslogng affects](#what-syslogng-affects)
    * [Beginning with syslogng](#beginning-with-syslogng)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

syslog-ng management without filtering capabilities

## Module Description

If applicable, this section should have a brief description of the technology
the module integrates with and what that integration enables. This section
should answer the questions: "What does this module *do*?" and "Why would I use
it?"

If your module has a range of functionality (installation, configuration,
management, etc.) this is the time to mention it.

## Setup

### What syslogng affects

* Package management
* EPEL installation via **eyp-epel**
* Configuration management
  - Log, source and destination configuration via resources
* Service management

### Beginning with syslogng

```puppet
class { 'syslogng':}
```

Sets **createdirs** to yes by default

## Usage

TODO

## Reference

### classes

#### syslogng

* **manage_package**:        = true,
* **package_ensure**:        = 'installed',
* **manage_service**:        = true,
* **manage_docker_service**: = true,
* **service_ensure**:        = 'running',
* **service_enable**:        = true,
* **createdirs**:            = true,

### resources

#### syslogng::destination

* **pathpattern**:,
* **destinationname**: = $name,
* **owner**:           = 'root',
* **group**:           = 'root',
* **filemode**:        = '0644',
* **dirmode**:         = '0755',
* **createdirs**:      = true

#### syslogng::log

* **sourcelist**:,
* **destinationlist**:,

#### syslogng::source

* **sourcename**:        = $name,
* **protocol**:          = 'udp',
* **port**:              = '514',

## Limitations

RHEL 6/7 and derivatives only

## Development

We are pushing to have acceptance testing in place, so any new feature should
have some test to check both presence and absence of any feature

### Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
