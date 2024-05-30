FILESEXTRAPATHS:prepend:ni-e31x := "${THISDIR}/files:"
FILESEXTRAPATHS:prepend:ni-neon := "${THISDIR}/files:"
FILESEXTRAPATHS:prepend:ni-sulfur := "${THISDIR}/files:"

SRC_URI:append:ni-e31x   = " file://rfnoc-ports.conf"
SRC_URI:append:ni-neon   = " file://rfnoc-ports.conf"
SRC_URI:append:ni-sulfur = " file://rfnoc-ports.conf"

do_install:append:ni-e31x() {
	install -D -m 0644 ${WORKDIR}/rfnoc-ports.conf ${D}/${sysconfdir}/sysctl.d/rfnoc-ports.conf
}

do_install:append:ni-neon() {
	install -D -m 0644 ${WORKDIR}/rfnoc-ports.conf ${D}/${sysconfdir}/sysctl.d/rfnoc-ports.conf
}

do_install:append:ni-sulfur() {
	install -D -m 0644 ${WORKDIR}/rfnoc-ports.conf ${D}/${sysconfdir}/sysctl.d/rfnoc-ports.conf
}
