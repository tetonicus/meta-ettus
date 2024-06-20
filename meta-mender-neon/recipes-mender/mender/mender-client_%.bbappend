FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append:ni-neon-mender = " \
    file://mender-device-identity \
    file://mender-inventory-serial \
"

PACKAGE_ARCH:ni-neon-mender = "${MACHINE_ARCH}"

SYSTEMD_AUTO_ENABLE:ni-neon-mender = "disable"

do_install:append:ni-neon-mender() {
	install -m 0755 ${WORKDIR}/mender-device-identity ${D}/${datadir}/mender/identity/mender-device-identity
	install -m 0755 ${WORKDIR}/mender-inventory-serial ${D}/${datadir}/mender/inventory/mender-inventory-serial
}
