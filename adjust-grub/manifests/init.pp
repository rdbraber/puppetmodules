class adjust-grub {
    augeas {'grub.conf/no_rhgb':
    incl    => '/boot/grub/grub.conf',
    lens    => 'grub.lns',
    changes => [
      'rm title[*]/kernel/rhgb',
      'rm title[*]/kernel/quiet'
    ],
  }
}
