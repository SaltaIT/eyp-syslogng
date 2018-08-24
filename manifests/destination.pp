define syslogng::destination(
                              $pathpattern,
                              $destinationname = $name,
                              $owner           = 'root',
                              $group           = 'root',
                              $filemode        = '0644',
                              $dirmode         = '0755',
                              $createdirs      = true
                            )
{

  concat::fragment{ "${syslogng::params::syslogngconf} destination ${destinationname} ${pathpattern}":
    target  => $syslogng::params::syslogngconf,
    order   => '93',
    content => template("${module_name}/destination.erb")
  }


}
