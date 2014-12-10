# == Class: oradb
#
class oradb ($shout = true) {

  if $::oradb::shout {
    notify {'oradb init.pp':}

  $puppetDownloadMntPoint = "/dbsoftware"

  oradb::installdb{ '112030_Linux-x86-64':
  version                => '11.2.0.3',
  file                   => 'p10404530_112030_Linux-x86-64',
  databaseType           => 'SE',
  oracleBase             => '/u01/app/oracle',
  oracleHome             => '/u01/app/oracle/product/11.2/db',
  eeOptionsSelection     => true,
  eeOptionalComponents   => 'oracle.rdbms.partitioning:11.2.0.3.0,oracle.oraolap:11.2.0.3.0,oracle.rdbms.dm:11.2.0.3.0,oracle.rdbms.dv:11.2.0.3.0,oracle.rdbms.lbac:11.2.0.3.0,oracle.rdbms.rat:11.2.0.3.0',
  createUser             => false,
  user                   => 'oracle',
  group                  => 'dba',
  group_install          => 'oinstall',
  group_oper             => 'oper',
  downloadDir            => '/dbsoftware',
  zipExtract             => false,
  puppetDownloadMntPoint => $puppetDownloadMntPoint,
}

oradb::database{ 'testDb_Create':
  oracleBase              => '/u01/app/oracle',
  oracleHome              => '/u01/app/oracle/product/11.2/db',
  version                 => '11.2',
  user                    => 'oracle',
  group                   => 'dba',
  downloadDir             => '/dbsoftware',
  action                  => 'create',
  dbName                  => 'test',
  dbDomain                => 'oracle.com',
  dbPort                  => '1521', #optional
  sysPassword             => 'Welcome01',
  systemPassword          => 'Welcome01',
  dataFileDestination     => "/u01/oradata",
  recoveryAreaDestination => "/u01/oracle/flash_recovery_area",
  characterSet            => "AL32UTF8",
  nationalCharacterSet    => "UTF8",
  initParams              => "open_cursors=1000,processes=600,job_queue_processes=4",
  sampleSchema            => 'TRUE',
  memoryPercentage        => "40",
  memoryTotal             => "800",
  databaseType            => "MULTIPURPOSE",
  emConfiguration         => "NONE",
  require                 => Oradb::Listener['start listener'],
}

oradb::net{ 'config net8':
  oracleHome   => '/u01/app/oracle/product/11.2/db',
  version      => '11.2',
  user         => 'oracle',
  group        => 'dba',
  downloadDir  => '/dbsoftware',
  dbPort       => '1521',
  require      => Oradb::Installdb['112030_Linux-x86-64'],
}

oradb::listener{'stop listener':
  oracleBase   => '/u01/app/oracle',
  oracleHome   => '/u01/app/oracle/product/11.2/db',
  user         => 'oracle',
  group        => 'dba',
  action       => 'start',
  require      => Oradb::Net['config net8'],
}

oradb::listener{'start listener':
  oracleBase   => '/u01/app/oracle',
  oracleHome   => '/u01/app/oracle/product/11.2/db',
  user         => 'oracle',
  group        => 'dba',
  action       => 'start',
  require      => Oradb::Listener['stop listener'],
}

}

}
