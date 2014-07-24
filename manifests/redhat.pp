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

    python::pip { 'tornado':
      pkgname => 'tornado',
    }

    package { 'datadog-agent':
      ensure  => latest,
      require => [ Yumrepo['datadog'], Python::Pip['tornado'] ],
    }

    service { "datadog-agent":
      ensure    => running,
      enable    => true,
      hasstatus => false,
      pattern   => 'dd-agent',
      require   => Package["datadog-agent"],
    }

}
