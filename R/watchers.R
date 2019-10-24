watch_remove = function(hook_name) {
    setHook(hook_name, NULL, "replace")
}

watch_register = function(x) {
    hook_name = packageEvent(x, "attach")

    # Verify hook hasn't been set yet.
    # Hooks that are not set, return an empty list with length 0.
    if (length(hook_name) != 0) {
        watch_remove(hook_name)
    }

    # Establish a new hook
    setHook(hook_name, function(...) {
        packageStartupMessage("Detected package load...")
        stop("The `", hook_name, "` package is not allowed.", call. = FALSE)
    })
}

watch_begins = function() {
    hooks_established = sapply(.pkgwatch$pkgs, FUN = watch_register)
    invisible(hooks_established)
}

watch_ends = function() {
    hooks_destroyed = sapply(.pkgwatch$pkgs, FUN = watch_remove)
    invisible(hooks_destroyed)
}
