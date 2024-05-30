FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " \
                 file://timesyncd.conf \
"

FILES:${PN}:append = " \
                     ${systemd_unitdir}/timesyncd.conf.d/ \
"

do_install:append() {
  install -D -m 0644 ${WORKDIR}/timesyncd.conf ${D}${systemd_unitdir}/timesyncd.conf.d/00-timesyncd.conf
}
