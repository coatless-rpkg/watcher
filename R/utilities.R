## Add the package to a list of watched packages
is_pkg_watched = function(x) {
    x %in% pkgwatch_env_packages()
}

is_pkg_not_watched = function(x) {
    !is_pkg_watched(x)
}
