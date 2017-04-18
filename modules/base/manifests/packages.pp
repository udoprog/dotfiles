class base::packages() {
  case $::osfamily {
    'Debian': {
      include ::base::packages::debian
    }
    default: {
      fail("unsupported osfamily: ${::osfamily}")
    }
  }
}
