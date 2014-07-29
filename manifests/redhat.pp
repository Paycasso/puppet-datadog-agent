# Class: datadog::redhat
#
# This class contains the DataDog agent installation mechanism for Red Hat derivatives
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class datadog::redhat {

    yumrepo {'datadog':
      enabled   => 1,
      gpgcheck  => 0,
      descr     => 'Datadog, Inc.',
      baseurl   => 'http://yum.datadoghq.com/rpm/',
    }

    package { 'python-pip':
      ensure => 'installed',
    }

    python::pip { 'tornado':
      pkgname => 'tornado',
      require => Package['python-pip'],
    }

    package { 'datadog-agent':
      ensure  => latest,
      require => [ Yumrepo['datadog'], Python::Pip['tornado'] ],
    }

}
