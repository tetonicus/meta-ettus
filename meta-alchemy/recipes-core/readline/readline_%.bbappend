# use custom inputrc file when building for the target
# (but not when building for the native host)
FILESEXTRAPATHS:prepend:class-target := "${THISDIR}/files:"
