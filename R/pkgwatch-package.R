#' @keywords internal
"_PACKAGE"

# The following block is used by usethis to automatically manage
# roxygen namespace tags. Modify with care!
## usethis namespace: start
## usethis namespace: end
NULL

# Environment
.pkgwatch = new.env()
.pkgwatch$pkgs = NULL


pkgwatch_env_packages = function() {
    .pkgwatch$pkgs
}

pkgwatch_env_add  = function(x) {
    if(is_pkg_not_watched(x)) {
        .pkgwatch$pkgs = c(.pkgwatch$pkgs, x)
    }
}

pkgwatch_env_remove  = function(x) {
    if(is_pkg_watched(x)) {
        .pkgwatch$pkgs = .pkgwatch$pkgs[!(.pkgwatch$pkgs %in% x)]
    }
}
