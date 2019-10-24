.onAttach = function(libname, pkgname) {
    watch_begins(output_msg = packageStartupMessage)
    invisible()
}

.onUnload = function(libpath) {
    watch_ended()
    invisible()
}
