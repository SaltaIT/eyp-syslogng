define syslogng::source (
                          $sourcename        = $name,
                          $protocol          = 'udp',
                          $port              = '514',
                        )
{

  validate_re($protocol, [ '^tcp$', '^udp$' ], 'supported protocols: tcp/udp')

  concat::fragment{ "${syslogng::params::syslogngconf} source ${sourcename} ${protocol} ${port}":
    target  => $syslogng::params::syslogngconf,
    order   => '92',
    content => template("${module_name}/source.erb"),
  }
}
