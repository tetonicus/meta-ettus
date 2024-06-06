require includes/maintainer-ettus.inc

SUMMARY = "Universal Hardware Driver for Ettus Research products (Hardware Daemon)."
HOMEPAGE = "http://www.ettus.com"
LICENSE = "GPL-3.0-or-later"

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += "file://0000-mpm-rpc_server-cast-get_device_info-get_mbeeprom-par.patch;patchdir=.. \
            file://0000-mpm-get_mender_artifact-fix-obsolete-command.patch;patchdir=.. \
            file://0001-mpm-tdc-fix-compatibility-with-Python-3.9.0.patch;patchdir=.. \
            file://0002-mpm-deactivate-Duplicate-Address-Detection-DAD-on-in.patch;patchdir=.. \
            file://0003-mpm-usrp_update_fs-correct-outdated-mender-command-i.patch;patchdir=.. \
            file://0004-mpm-avoid-importing-from-rpc_server-when-importing-u.patch;patchdir=.. \
           "

DEPENDS = " boost \
	    udev \
	    pkgconfig-native \
	    python3-setuptools-native \
	    python3-mako-native \
          "
RDEPENDS:${PN} = " \
                  python3-core \
                  python3-netaddr \
                  python3-pyudev \
                  python3-gevent \
                  python3-systemd \
                  python3-requests \
                  python3-mprpc \
                  python3-multiprocessing \
                  python3-mmap \
                  python3-fcntl \
                  python3-six \
                  python3-pyroute2 \
                  python3-mako \
                  python3-statistics \
                  udev \
                  dtc \
                  uhd-fpga-images-firmware \
                  usrp-firmware \
                  iptables \
                  libgpiod-python \
                 "
RDEPENDS:${PN}-tools = " \
                  bash \
                 "

RDEPENDS:${PN}-tests = " \
                  ${PN} \
                  python3-unittest-xml-reporting \
                  "
PACKAGE_ARCH = "${MACHINE_ARCH}"

inherit setuptools3-base cmake python3-dir python3native systemd
include uhd_auto_pkgv.inc

S = "${WORKDIR}/git/mpm"

MPM_DEVICE ?= "sim"
MPM_DEVICE:ni-e31x = "e31x"
MPM_DEVICE:ni-neon = "e320"
MPM_DEVICE:ni-sulfur = "n3xx"

EXTRA_OECMAKE:append = " \
                  -DCMAKE_SKIP_RPATH=ON \
                  -DMPM_DEVICE=${MPM_DEVICE} \
                  -DGIT_EXECUTABLE=${HOSTTOOLS_DIR}/git \
                  -DPYTHON_EXECUTABLE=${PYTHON} \
                  -DRUNTIME_PYTHON_EXECUTABLE=/usr/bin/python3 \
                  "

SYSTEMD_PACKAGES = "${@bb.utils.contains('DISTRO_FEATURES','systemd','${PN}','',d)}"
SYSTEMD_SERVICE:${PN} = "${@bb.utils.contains('DISTRO_FEATURES','systemd','usrp-hwd.service','',d)}"

PACKAGES =+ "${PN}-tools ${PN}-tests"

FILES:${PN}     += "${systemd_unitdir}/network/*"
FILES:${PN}-dev += "${libdir}/libusrp-periphs.so"
FILES:${PN}-dbg += "${bindir}/mpm_debug.py"
FILES:${PN}-tools += " ${bindir}/eeprom-*"
FILES:${PN}-tests = "${libdir}/usrp_mpm/tests"

do_install:append() {
    mkdir -p ${D}${libdir}/usrp_mpm/tests/
    install -m 0644 ${S}/python/tests/*.py ${D}${libdir}/usrp_mpm/tests/

    if [ -d ${S}/python/tests/eeprom_tests ]; then
	    mkdir -p ${D}${libdir}/usrp_mpm/tests/eeprom_tests/
	    install -m 0644 ${S}/python/tests/eeprom_tests/*.eeprom ${D}${libdir}/usrp_mpm/tests/eeprom_tests/
    fi

    # prepend "40-" when installing .network files (e.g. eth0.network ->
    # 40-eth0.network) to make sure that the rules are applied before the
    # systemd default rules like 80-wired.network
    if [ -d ${D}${base_libdir}/systemd/network ]; then
        for FILENAME in ${D}${base_libdir}/systemd/network/*.network; do
            DIRNAME="$(dirname "$FILENAME")"
            BASENAME="$(basename "$FILENAME")"
            NEWNAME="40-$BASENAME"
            mv "$DIRNAME/$BASENAME" "$DIRNAME/$NEWNAME"
        done
    fi
}
