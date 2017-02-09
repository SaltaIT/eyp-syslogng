class syslogng  (
                  $ensure = 'installed',
                  $createdirs=true,
                  $syslogng_conf_file=undef,
                ) inherits params {

  validate_re($ensure, [ '^installed$', '^latest$', '^purged$' ], "Not a valid package status: ${ensure}")

  include epel

  package { $syslogng::params::syslogng_package:
    ensure => $ensure,
    require => Class['epel'],
  }

  if($ensure=='installed' or $ensure=='latest')
  {
    $ensure_rsyslogservice='stopped'
    $enable_rsyslogservice=false
    $enable_syslogservice=true
    $ensure_syslogservice='running'
    $ensure_syslogconf='present'
  }
  else
  {
    $ensure_rsyslogservice='running'
    $enable_rsyslogservice=true
    $enable_syslogservice=false
    $ensure_syslogservice='stopped'
    $ensure_syslogconf='absent'
  }

  concat { $syslogng::params::syslogngconf:
    ensure => $ensure_syslogconf,
    owner => 'root',
    group => 'root',
    mode => '0644',
    require => Package[$syslogng::params::syslogng_package],
    notify => Service[$syslogng::params::syslogng_servicename],
  }

  if($syslogng_conf_file)
  {
    concat::fragment{ "${syslogng::params::syslogngconf} baseconf":
      target  => $syslogng::params::syslogngconf,
      order => '01',
      source => $syslogng_conf_file,
    }
  }
  else
  {
    concat::fragment{ "${syslogng::params::syslogngconf} baseconf":
      target  => $syslogng::params::syslogngconf,
      order => '01',
      content => template("syslogng/syslogngconf.erb"),
    }
  }

  service { $syslogng::params::rsyslog_servicename:
    enable => $enable_rsyslogservice,
    require => Concat[$syslogng::params::syslogngconf],
  }

  service { $syslogng::params::syslogng_servicename:
    ensure => $ensure_syslogservice,
    enable => $enable_syslogservice,
    require => Service[$syslogng::params::rsyslog_servicename],
  }

}
