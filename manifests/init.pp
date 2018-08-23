class syslogng  (
                  $manage_package        = true,
                  $package_ensure        = 'installed',
                  $manage_service        = true,
                  $manage_docker_service = true,
                  $service_ensure        = 'running',
                  $service_enable        = true,
                  $createdirs            = true,
                ) inherits syslogng::params {

  class { 'syslogng::install': } ->
  class { 'syslogng::config': } ~>
  class { 'syslogng::service': } ->
  Class['::syslogng']

}
