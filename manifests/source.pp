define syslogng::source (
                          $sourcename        = $name,
                          $protocol          = 'udp',
                          $port              = '514',
                          $tlskey            = undef,
                          $tlscert           = undef,
                          $peerverify        = false,
                          $subjectselfsigned = undef,
                        )
{

  validate_re($protocol, [ '^tcp$', '^udp$' ], "supported protocols: tcp/udp")

  if($tlskey or $tlscert or $subjectselfsigned)
  {
    if ! defined(Package['openssl'])
    {
      package { 'openssl':
        ensure => installed,
      }
    }

    if($subjectselfsigned!=undef)
    {
      exec { "openssl pk ${sourcename}":
        command => "/usr/bin/openssl genrsa -out /etc/pki/tls/private/syslogng-${sourcename}.key 2048",
        creates => "/etc/pki/tls/private/syslogng-${sourcename}.key",
        notify  => Service[$syslogng::params::syslogng_servicename],
        require => Package['openssl'],
      }

      exec { "openssl cert ${sourcename}":
        command => "/usr/bin/openssl req -new -key /etc/pki/tls/private/syslogng-${sourcename}.key -subj '${subjectselfsigned}' | /usr/bin/openssl x509 -req -days 10000 -signkey /etc/pki/tls/private/syslogng-${sourcename}.key -out /etc/pki/tls/certs/syslogng-${sourcename}.pem",
        creates => "/etc/pki/tls/certs/syslogng-${sourcename}.pem",
        notify  => Service[$syslogng::params::syslogng_servicename],
        require => Exec["openssl pk ${sourcename}"],
      }
    }
    elsif($tlscert and $tlskey)
    {
      validate_string($tlscert)
      validate_string($tlskey)

      file { "/etc/pki/tls/private/syslogng-${sourcename}.key":
				ensure => present,
				owner => "root",
				group => "root",
				mode => 0644,
				require => Package['openssl'],
				notify  => Service[$syslogng::params::syslogng_servicename],
				audit => 'content',
				source => $tlspk
			}

			file { "/etc/pki/tls/certs/syslogng-${sourcename}.pem":
				ensure => present,
				owner => "root",
				group => "root",
				mode => 0644,
				require => Package['openssl'],
				notify  => Service[$syslogng::params::syslogng_servicename],
				audit => 'content',
				source => $tlscert
			}
    }
    else
    {
      fail("everytime you forget required a TLS file, God kills a kitten - please think of the kittens")
    }
  }

  concat::fragment{ "${syslogngconf} source ${sourcename} ${protocol} ${port}":
    target  => $syslogng::params::syslogngconf,
    order => '92',
    content => template("syslogng/source.erb"),
  }
}
