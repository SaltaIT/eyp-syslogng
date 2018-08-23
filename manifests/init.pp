class syslogng  (
                  $manage_package        = true,
                  $package_ensure        = 'installed',
                  $manage_service        = true,
                  $manage_docker_service = true,
                  $service_ensure        = 'running',
                  $service_enable        = true,
                ) inherits syslogng::params {

  if($package_ensure=='installed' or $package_ensure=='latest')
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

  class { '::syslogng::install': } ->
  class { '::syslogng::config': } ~>
  class { '::syslogng::service': } ->
  Class['::syslogng']

}
