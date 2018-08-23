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
    content => inline_template("\ndestination ${destinationname} { file(\"${pathpattern}\" \
    \n\towner(${owner}) group(${group}) perm(${filemode}) dir_perm(${dirmode}) \
    <% if @createdirs %>create_dirs(yes)<% else %>create_dirs(no)<% end %>);\
    \n};\n\n"),
  }


}
