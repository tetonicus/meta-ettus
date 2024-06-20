FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append:ni-titanium-mender = " \
    file://mender-device-identity \
    file://mender-inventory-serial \
"

PACKAGE_ARCH:ni-titanium-mender = "${MACHINE_ARCH}"

SYSTEMD_AUTO_ENABLE:ni-titanium-mender = "disable"

do_install:append:ni-titanium-mender() {
	install -m 0755 ${WORKDIR}/mender-device-identity ${D}/${datadir}/mender/identity/mender-device-identity
	install -m 0755 ${WORKDIR}/mender-inventory-serial ${D}/${datadir}/mender/inventory/mender-inventory-serial
}
