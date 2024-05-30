inherit uhd_images_downloader

UHD_IMAGES_TO_DOWNLOAD:ni-sulfur ?= " \
    n3xx_n310_cpld_default \
    n3xx_n320_cpld_default \
    "

EXTRA_PACKAGES:ni-sulfur += " \
    ${PN}-ni-magnesium \
    ${PN}-ni-rhodium \
    "

# The CPLD image is GPL2 or X11 licensed

FILES:${PN}-ni-magnesium = " \
    ${nonarch_base_libdir}/firmware/ni/cpld-magnesium-revc.svf \
    "

LICENSE:${PN}-ni-magnesium = "Firmware-GPLv2"
# TODO re-add:
# RDEPENDS:${PN}-ni-magnesium += "${PN}-gplv2-license"

FILES:${PN}-ni-rhodium = " \
    ${nonarch_base_libdir}/firmware/ni/cpld-rhodium-revb.svf \
    "

LICENSE:${PN}-ni-rhodium = "Firmware-GPLv2"
# TODO re-add:
# RDEPENDS:${PN}-ni-rhodium += "${PN}-gplv2-license"

do_install:append:ni-sulfur() {
    ### CPLD firmware

    install -m 0644 ${S}/usrp_n310_mg_cpld.svf ${D}${nonarch_base_libdir}/firmware/ni/cpld-magnesium-revc.svf
    # This workaround ultimately should go away once the .svf is generated correctly
    sed -i -e 's/FREQUENCY 1.80E+07/FREQUENCY 1.00E+07/g' ${D}${nonarch_base_libdir}/firmware/ni/cpld-magnesium-revc.svf

    install -m 0644 ${S}/usrp_n320_rh_cpld.svf ${D}${nonarch_base_libdir}/firmware/ni/cpld-rhodium-revb.svf
}
