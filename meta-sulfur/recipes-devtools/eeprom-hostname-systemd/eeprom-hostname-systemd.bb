require includes/maintainer-ettus.inc

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
DESCRIPTION = "Hostname utility for the Ettus Research Sulfur SDR"
PV="0.10"

LICENSE = "GPL-2.0-or-later"
LIC_FILES_CHKSUM = "file://${WORKDIR}/COPYING;md5=b234ee4d69f5fce4486a80fdaf4a4263"

PR="r5"

COMPATIBLE_MACHINE = "ni-sulfur"
PACKAGE_ARCH = "${MACHINE_ARCH}"

inherit systemd
SYSTEMD_PACKAGES = "${PN}"
SYSTEMD_SERVICE:${PN}= "hostname-serial.service"

SRC_URI = " \
           file://COPYING \
           file://usrp_hostname \
           file://hostname-serial.service"

FILES:${PN} = "${base_libdir}/systemd/system/ \
               ${base_sbindir} \
              "
RDEPENDS:${PN} = "bash mpmd-tools"

do_install:append() {
	install -d ${D}${base_libdir}/systemd/system
	install -d ${D}${base_sbindir}
	install -m 0644 ${WORKDIR}/hostname-serial.service ${D}${base_libdir}/systemd/system/
	install -m 0755 ${WORKDIR}/usrp_hostname ${D}${base_sbindir}/usrp_hostname
}
