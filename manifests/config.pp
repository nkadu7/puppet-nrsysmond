class nrsysmond::config(
  $license_key,
  $nrloglevel     = $nrsysmond::params::loglevel,
  $nrlogfile      = $nrsysmond::params::logfile,
  $proxy          = undef,
  $ssl            = undef,
  $ssl_ca_bundle  = undef,
  $ssl_ca_path    = undef,
  $nrpidfile      = undef,
  $collector_host = undef,
  $timeout        = undef
) inherits nrsysmond::params {

  validate_re($license_key, '[0-9a-fA-F]{40}', 'License key is not a 40 character hexadecimal string')

  if (!member(['error', 'warning', 'info',
               'verbose', 'debug', 'verbosedebug'], $nrloglevel)) {
    fail("Log level of ${nrloglevel} was invalid.")
  }

  file { '/etc/newrelic/nrsysmond.cfg':
    owner    => root,
    group    => root,
    mode     => 644,
    content  => template('nrsysmond/nrsysmond.cfg.erb'),
    notify   => Service["newrelic-sysmond"],
  }
}
