# Class: ssh_keys
#
# This module manages the ssh_keys
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#  include ssh_keys
#
# [Remember: No empty lines between comments and class definition]
class ssh_keys {

  if $kernel == "Linux" {
    file { "/root/.ssh":
#      type    => "directory",
      ensure  => "directory",
      backup  => "false",
      owner   => "root",
      group   => "root",
      mode    => "0600",
    }

    file { "/root/.ssh/authorized_keys":
      ensure  => "file",
      backup  => "false",
      owner   => "root",
      group   => "root",
      mode    => "0400",
      source  => "puppet:///modules/ssh_keys/authorized_keys", 

    }

  }

}
