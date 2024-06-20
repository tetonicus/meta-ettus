FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
    file://0001-watchdog-use-dev-watchdog0-only-if-it-exists.patch \
    file://0001-network-do-not-enable-IPv4-ACD-for-IPv4-link-local-a.patch \
    file://0001-proc-dont-trigger-mount-error-with-invalid-options.patch \
    "
