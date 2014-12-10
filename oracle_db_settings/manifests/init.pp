# Class: oracle_db_settings
#
# This module manages the settings for installing an Oracle database
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#  include oracle_db_settings
#
# [Remember: No empty lines between comments and class definition]
class oracle_db_settings {

  group { 'oinstall':
    ensure => 'present',
    gid    => '3001',
  }

  group { 'dba':
    ensure  => 'present',
    gid     => '3002',
  }

  group { 'oper':
    ensure  => 'present',
    gid     => '3003',
  }

  user { 'oracle':
    ensure  	   => 'present',
    comment        => 'NPA',
    gid              => '3002',
    groups           => ['oinstall','oper'],
    home             => '/home/oracle/',
    managehome	     => true,
    password         => '$6$TdQGH1xQf8y6vVro$J8CDXjimcWxOoIoJG0MT4HC2Ig6yajJ7aepDQgbh5DvT0IOBZmsP8Z6EtLaoOkqKVpMJxN0G2ugk0Eu6bYx5K1',
    shell            => '/bin/bash',
    uid              => '4000',
    }


  package { 'nfs-utils':
    ensure	=> 'present',
  }

  package { 'compat-libcap1':
    ensure      => 'present',
  }

  package { 'ksh':
    ensure      => 'present',
  }

  package { 'libXtst':
    ensure      => 'present',
  }

  package { 'libXv':
    ensure      => 'present',
  }

  package { 'libXxf86dga':
    ensure      => 'present',
  }

  package { 'libdmx':
    ensure      => 'present',
  }

  package { 'xorg-x11-utils':
    ensure      => 'present',
  }

  package { 'cloog-ppl':
    ensure      => 'present',
  }

  package { 'compat-libstdc++-33':
    ensure      => 'present',
  }

  package { 'cpp':
    ensure      => 'present',
  }

  package { 'gcc':
    ensure      => 'present',
  }

  package { 'gcc-c++':
    ensure      => 'present',
  }

  package { 'glibc-devel':
    ensure      => 'present',
  }

  package { 'glibc-headers':
    ensure      => 'present',
  }

#  package { 'kernel-uek-headers':
#    ensure      => 'present',
#  }

  package { 'libICE':
    ensure      => 'present',
  }

  package { 'libSM':
    ensure      => 'present',
  }

  package { 'libXmu':
    ensure      => 'present',
  }

  package { 'libXt':
    ensure      => 'present',
  }

  package { 'libaio-devel':
    ensure      => 'present',
  }

  package { 'libgomp':
    ensure      => 'present',
  }

  package { 'libstdc++-devel':
    ensure      => 'present',
  }

  package { 'mpfr':
    ensure      => 'present',
  }

  package { 'ppl':
    ensure      => 'present',
  }

  package { 'xorg-x11-xauth':
    ensure      => 'present',
  }



include sysctl

sysctl::conf {

  "kernel.sem":				value => "250 32000 100 128";
  "net.ipv4.ip_local_port_range": 	value => "9000 65500";
  "net.core.rmem_default": 		value => 4194304;
  "net.core.rmem_max": 			value => 4194304;
  "net.core.wmem_default":		value => 262144;
  "net.core.wmem_max": 			value => 1048576;
  "fs.aio-max-nr": 			value => 1048576;
  "fs.file-max": 			value => 6815744;
  "vm.swappiness":			value => 100;
  "kernel.shmmni":			value => 4096;
  }

#include limits

class { 'limits':
  config => {
    'oracle' => {
      'nofile' => {
        soft => '1024',
        hard => '65536',
      },
      'nproc' => {
        soft => '2047',
        hard => '16384',
      },
    },
  },
  use_hiera => false,
}

    file { "/etc/profile":
      ensure  => "file",
      backup  => "false",
      owner   => "root",
      group   => "root",
      mode    => "0644",
      source  => "puppet:///modules/oracle_db_settings/profile", 

    }

    file { "/home/oracle/.bash_profile":
      ensure  => "file",
      backup  => "false",
      owner   => "oracle",
      group   => "dba",
      mode    => "0644",
      source  => "puppet:///modules/oracle_db_settings/bash_profile",

    }

    file { "/u01":
      ensure  => "directory",
      owner   => "oracle",
      group   => "oinstall",
      mode    => "0775",
    }

    file { "/u01/app":
      ensure  => "directory",
      owner   => "oracle",
      group   => "oinstall",
      mode    => "0775",
    }

    file { "/u01/app/oracle":
      ensure  => "directory",
      owner   => "oracle",
      group   => "oinstall",
      mode    => "0775",
    }

    file { "/u01/app/oracle/product":
      ensure  => "directory",
      owner   => "oracle",
      group   => "oinstall",
      mode    => "0775",
    }

    file { "/u01/app/oracle/product/11.2":
      ensure  => "directory",
      owner   => "oracle",
      group   => "oinstall",
      mode    => "0775",
    }

    file { "/dbsoftware":
      ensure  => "directory",
    }
   
    mount { "/dbsoftware":
	device    => "puppetmaster:/repos/dbsoftware",
      fstype    => "nfs",
        ensure    => "mounted",
        options   => "defaults,ro",
        atboot    => "true",
	require   => File['/dbsoftware'],
    }

}
