class syslogng::service inherits syslogng {
  validate_bool($syslogng::manage_docker_service)
  validate_bool($syslogng::manage_service)
  validate_bool($syslogng::service_enable)

  validate_re($syslogng::service_ensure, [ '^running$', '^stopped$' ], "Not a valid daemon status: ${syslogng::service_ensure}")

  $is_docker_container_var=getvar('::eyp_docker_iscontainer')
  $is_docker_container=str2bool($is_docker_container_var)

  if( $is_docker_container==false or
      $syslogng::manage_docker_service)
  {
    if($syslogng::manage_service)
    {
      class { 'rsyslog':
        service_ensure => $syslogng::ensure_rsyslogservice,
        service_enable => $syslogng::enable_rsyslogservice,
      }

      ->

      service { $syslogng::params::syslogng_servicename:
        ensure => $syslogng::ensure_syslogservice,
        enable => $syslogng::enable_syslogservice,
      }
    }
  }

}
