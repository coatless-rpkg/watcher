#' Add, remove, or see package watches
#'
#' Setups, destructs, or shows the watch for when a package
#' is loaded into _R_.
#'
#' @param pkg     Name of the Package to actively watch for.
#' @param verbose Provide a message indicating addition or removal of watch.
#'
#' @export
#' @rdname watch_pkg
#' @examples
#' # Prevent a package from being used.
#' watch_pkg("pkgname")
#'
#' # Show active watches
#' watchlist()
#'
#' # Allow a package to be used again.
#' unwatch_pkg("pkgname")
watch_pkg = function(pkg, verbose = TRUE) {

  if (is_pkg_watched(pkg)) {
    message("A watch for {", pkg, "} has already been established.")
    return(invisible())
  }

  if (verbose) {
    message("Added a watch for {", pkg, "}.")
  }

  hook_name = packageEvent(pkg, "attach")
  pkgwatch_env_add(pkg)

  # Establish a new hook
  setHook(hook_name, function(...) {
    message("Detected {", pkg, "} package load...")
    detach(paste0("package:", pkg), unload = TRUE, force = TRUE,
           character.only = TRUE)
    message("The {", pkg, "} package is not allowed to be used.")
  })
}

#' @export
#' @rdname watch_pkg
unwatch_pkg = function(pkg, verbose = TRUE) {
  if (is_pkg_not_watched(pkg)) {
    message("There isn't a watch yet for {", pkg, "}.")
    return(invisible())
  }

  if (verbose) {
    message("Removed a watch for {", pkg, "}.")
  }

  pkgwatch_env_remove(pkg)
  hook_name = packageEvent(pkg, "attach")
  setHook(hook_name, NULL, "replace")
}

#' @rdname watch_pkg
#' @export
watchlist = function() {
  watch_active_list_output(output_msg = message)
}


## Used during package loads ----

watch_begins = function(output_msg = packageStartupMessage) {

  pkgs = pkgwatch_env_packages()
  watch_active_list_output(output_msg = output_msg)
  hooks_established = sapply(pkgs, FUN = watch_pkg, verbose = FALSE)

  invisible(hooks_established)
}

watch_ends = function(output_msg = message) {
  pkgs = pkgwatch_env_packages()

  output_msg("All packages are allowed to be loaded again.")
  hooks_destroyed = sapply(pkgs, FUN = unwatch_pkg, verbose = FALSE)

  invisible(hooks_destroyed)
}

watch_active_list_output = function(output_msg = message) {
  pkgs = pkgwatch_env_packages()
  if (length(pkgs)) {
    output_msg("The following packages are prohibited from being used:\n")
    output_msg(paste("* ", pkgs, collapse = "\n"))
  } else {
    output_msg("No packages are currently prohibited from being used.")
  }
}

