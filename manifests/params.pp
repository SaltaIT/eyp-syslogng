class syslogng::params {

	case $::osfamily
	{
		'redhat':
		{
			case $::operatingsystemrelease
			{
				/^6.*$/:
				{
					$syslogng_package='syslog-ng'
					$rsyslog_servicename='rsyslog'
					$syslogng_servicename='syslog-ng'
					$syslogngconf='/etc/syslog-ng/syslog-ng.conf'
				}
			default: { fail("Unsupported RHEL/CentOS version!")  }
			}
		}
		default: { fail("Unsupported OS!")  }
	}
}
