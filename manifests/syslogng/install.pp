class syslogng::install inherits syslogng {
  include epel

  package { $syslogng::params::syslogng_package:
    ensure  => $syslogng::package_ensure,
    require => Class['epel'],
  }
}
