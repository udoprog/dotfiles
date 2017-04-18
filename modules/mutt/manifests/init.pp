class mutt() {
  case $::osfamily {
    'Debian': {
      include ::mutt::package::debian
    }
    default: {
      fail("unsupported osfamily: ${::osfamily}")
    }
  }
}
