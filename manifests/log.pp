define syslogng::log(
                      $sourcelist,
                      $destinationlist,
                    )
{

  validate_array($sourcelist)
  validate_array($destinationlist)

  concat::fragment{ "${syslogng::params::syslogngconf} log ${name}":
    target  => $syslogng::params::syslogngconf,
    order   => '94',
    content => template("${module_name}/log.erb"),
    require => [ Syslogng::Source[$sourcelist], Syslogng::Destination[$destinationlist]],
  }
}
