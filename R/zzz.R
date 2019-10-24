.onAttach = function(libname, pkgname) {
    watch_begins()
    invisible()
}

.onUnload = function(libpath) {
    watch_ended()
    invisible()
}
