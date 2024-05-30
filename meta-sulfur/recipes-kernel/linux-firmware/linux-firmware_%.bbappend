inherit uhd_images_downloader

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " file://ec-sulfur-rev3.bin \
                   file://ec-sulfur-rev3.RW.bin \
                   file://ec-sulfur-rev5.bin \
                   file://ec-sulfur-rev5.RW.bin \
                   file://LICENSE.ec-sulfur \
                   file://mykonos-m3.bin \
                 "

LICENSE:append = "& Firmware-ni-sulfur"
LIC_FILES_CHKSUM:append = "file://${WORKDIR}/LICENSE.ec-sulfur;md5=72f855f00b364ec8bdc025e1a36b39c3"

NO_GENERIC_LICENSE[Firmware-ni-sulfur] = "${WORKDIR}/LICENSE.ec-sulfur"
LICENSE:-ni-sulfur = "Firmware-ni-sulfur"

PACKAGE_BEFORE_PN:ni-sulfur = " \
    ${PN}-ni-sulfur-license \
    ${PN}-ni-sulfur \
    ${PN}-ni-magnesium \
    ${PN}-ni-rhodium \
    ${PN}-ni-sulfur-fpga \
    ${PN}-ni-phosphorus-fpga \
    ${PN}-ni-rhodium-fpga \
    ${PN}-adi-mykonos \
    "

# The EC image is under the Chromium License, so add custom license file
FILES:-ni-sulfur-license = " \
                        ${nonarch_base_libdir}/firmware/ni/LICENSE.ec-sulfur \
                        "
FILES:-ni-sulfur = "${nonarch_base_libdir}/firmware/ni/ec-sulfur*.bin \
                         ${nonarch_base_libdir}/firmware/ni/ec-phosphorus*.bin \
                        "
RDEPENDS:-ni-sulfur += "${PN}-ni-sulfur-license"


# The FPGA images are provided by the uhd-fpga-images recipe
ALLOW_EMPTY:-ni-sulfur-fpga = "1"
RDEPENDS:-ni-sulfur-fpga = "uhd-fpga-images-n310-firmware"

ALLOW_EMPTY:-ni-phosphorus-fpga = "1"
RDEPENDS:-ni-phosphorus-fpga = "uhd-fpga-images-n300-firmware"

ALLOW_EMPTY:-ni-rhodium-fpga = "1"
RDEPENDS:-ni-rhodium-fpga = "uhd-fpga-images-n320-firmware"


# The CPLD image is GPL2 or X11 licensed
FILES:-ni-magnesium = " \
                           ${nonarch_base_libdir}/firmware/ni/cpld-magnesium-revc.svf \
                           "

LICENSE:-ni-magnesium = "Firmware-GPLv2"
RDEPENDS:-ni-magnesium += "${PN}-gplv2-license"

FILES:-ni-rhodium = " \
                           ${nonarch_base_libdir}/firmware/ni/cpld-rhodium-revb.svf \
                           "

LICENSE:-ni-rhodium = "Firmware-GPLv2"
RDEPENDS:-ni-rhodium += "${PN}-gplv2-license"

UHD_IMAGES_TO_DOWNLOAD:ni-sulfur ?= " \
    n3xx_n310_cpld_default \
    n3xx_n320_cpld_default \
    "

UHD_IMAGES_DOWNLOAD_DIR:ni-sulfur = "${WORKDIR}"

do_install:append:ni-sulfur() {

    ### Microcontroller firmware

    # legacy rev. 3 firmware
    install -D -m 0644 ${WORKDIR}/ec-sulfur-rev3.bin ${D}${nonarch_base_libdir}/firmware/ni/ec-sulfur-rev3.bin
    install -m 0644 ${WORKDIR}/ec-sulfur-rev3.RW.bin ${D}${nonarch_base_libdir}/firmware/ni/ec-sulfur-rev3.RW.bin

    # Rev5+ firmware now differs from rev3 firmware, since it adds more margin in bootdelay
    # Rev 10+ firmware uses GPIOs which can en-/disable the 12V of the daughter cards and the fans
    # Rev 4+ all use the same firmware
    install -D -m 0644 ${WORKDIR}/ec-sulfur-rev5.bin ${D}${nonarch_base_libdir}/firmware/ni/ec-sulfur-rev5.bin
    install -m 0644 ${WORKDIR}/ec-sulfur-rev5.RW.bin ${D}${nonarch_base_libdir}/firmware/ni/ec-sulfur-rev5.RW.bin

    for REV in 4 6 7 8 9 10 11
    do
      ln -sf ec-sulfur-rev5.bin ${D}${nonarch_base_libdir}/firmware/ni/ec-sulfur-rev${REV}.bin
      ln -sf ec-sulfur-rev5.RW.bin ${D}${nonarch_base_libdir}/firmware/ni/ec-sulfur-rev${REV}.RW.bin
    done

    for REV in 4 5 6 7 8 9 10 11
    do
      ln -sf ec-sulfur-rev5.bin ${D}${nonarch_base_libdir}/firmware/ni/ec-phosphorus-rev${REV}.bin
      ln -sf ec-sulfur-rev5.RW.bin ${D}${nonarch_base_libdir}/firmware/ni/ec-phosphorus-rev${REV}.RW.bin
    done

    install -m 0644 ${WORKDIR}/LICENSE.ec-sulfur ${D}${nonarch_base_libdir}/firmware/ni/LICENSE.ec-sulfur

    ### CPLD firmware

    install -m 0644 ${WORKDIR}/usrp_n310_mg_cpld.svf ${D}${nonarch_base_libdir}/firmware/ni/cpld-magnesium-revc.svf
    # This workaround ultimately should go away once the .svf is generated correctly
    sed -i -e 's/FREQUENCY 1.80E+07/FREQUENCY 1.00E+07/g' ${D}${nonarch_base_libdir}/firmware/ni/cpld-magnesium-revc.svf

    install -m 0644 ${WORKDIR}/usrp_n320_rh_cpld.svf ${D}${nonarch_base_libdir}/firmware/ni/cpld-rhodium-revb.svf

    install -D -m 0644 ${WORKDIR}/mykonos-m3.bin ${D}${nonarch_base_libdir}/firmware/adi/mykonos-m3.bin
}

FILES:-adi-mykonos = " \
                           ${nonarch_base_libdir}/firmware/adi/mykonos-m3.bin \
                          "
LICENSE:-adi-mykonos = "CLOSED"
