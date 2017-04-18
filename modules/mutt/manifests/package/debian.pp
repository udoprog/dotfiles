class mutt::package::debian() {
  package { 'mutt':
    ensure => latest,
  }
}
