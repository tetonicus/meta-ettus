inherit uhd_images_downloader

LICENSE = "LGPL-3.0-or-later"

FILES:${PN} = " \
    /lib/firmware/ni/cpld-x410-*.* \
    /lib/firmware/ni/cpld-zbx-*.* \
    /lib/firmware/ni/cpld-x440-*.* \
    "

UHD_IMAGES_TO_DOWNLOAD:ni-titanium ?= " \
    ${@ '' if d.getVar('EXTERNALSRC') else 'x4xx_x410_cpld_default'} \
    ${@ '' if d.getVar('EXTERNALSRC') else 'x4xx_x440_cpld_default'} \
    ${@ '' if d.getVar('EXTERNALSRC') else 'x4xx_zbx_cpld_default'} \
    "

MB_CPLD_SUBDIRECTORY ?= ""
ZBX_CPLD_SUBDIRECTORY ?= ""

do_install() {
    install -d "${D}/lib/firmware/ni"
    install -D "${S}/${MB_CPLD_SUBDIRECTORY}/usrp_x410_cpld_10m04.rpd" "${D}/lib/firmware/ni/cpld-x410-10m04.rpd"
    install -D "${S}/${MB_CPLD_SUBDIRECTORY}/usrp_x410_cpld_10m04.svf" "${D}/lib/firmware/ni/cpld-x410-10m04.svf"
    install -D "${S}/${MB_CPLD_SUBDIRECTORY}/usrp_x410_cpld_10m08.rpd" "${D}/lib/firmware/ni/cpld-x410-10m08.rpd"
    install -D "${S}/${MB_CPLD_SUBDIRECTORY}/usrp_x410_cpld_10m08.svf" "${D}/lib/firmware/ni/cpld-x410-10m08.svf"
    install -D "${S}/${MB_CPLD_SUBDIRECTORY}/usrp_x440_cpld_10m04.rpd" "${D}/lib/firmware/ni/cpld-x440-10m04.rpd"
    install -D "${S}/${MB_CPLD_SUBDIRECTORY}/usrp_x440_cpld_10m04.svf" "${D}/lib/firmware/ni/cpld-x440-10m04.svf"
    install -D "${S}/${MB_CPLD_SUBDIRECTORY}/usrp_x440_cpld_10m08.rpd" "${D}/lib/firmware/ni/cpld-x440-10m08.rpd"
    install -D "${S}/${MB_CPLD_SUBDIRECTORY}/usrp_x440_cpld_10m08.svf" "${D}/lib/firmware/ni/cpld-x440-10m08.svf"
    install -D "${S}/${ZBX_CPLD_SUBDIRECTORY}/usrp_zbx_cpld_10m04.rpd" "${D}/lib/firmware/ni/cpld-zbx-10m04.rpd"
    install -D "${S}/${ZBX_CPLD_SUBDIRECTORY}/usrp_zbx_cpld_10m04.svf" "${D}/lib/firmware/ni/cpld-zbx-10m04.svf"
    install -D "${S}/${ZBX_CPLD_SUBDIRECTORY}/usrp_zbx_cpld_xo3lf.svf" "${D}/lib/firmware/ni/cpld-zbx-xo3lf.svf"
}
