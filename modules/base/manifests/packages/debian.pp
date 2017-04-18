class base::packages::debian($list) {
  package { $list:
    ensure => latest,
  }
}
