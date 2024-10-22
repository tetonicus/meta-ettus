inherit uhd_images_downloader

# FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

# SRC_URI:append:ni-titanium = " \
#     file://set-symlinks.py \
#     "

FILES:${PN}:ni-titanium = " \
    ${UHD_IMAGES_INSTALL_PATH}/usrp_x410_fpga*.* \
    ${UHD_IMAGES_INSTALL_PATH}/usrp_x440_fpga*.* \
    "
FILES:${PN}-inventory:ni-titanium = "${UHD_IMAGES_INSTALL_PATH}/inventory.json"
FILES:${PN}-firmware:ni-titanium = " \
    /lib/firmware/x410.orig.bin \
    /lib/firmware/x410.orig.dtbo \
    /lib/firmware/x410.bin \
    /lib/firmware/x410.dtbo \
    /lib/firmware/x440.bin \
    /lib/firmware/x440.dtbo \
    "

UHD_IMAGES_TO_DOWNLOAD:ni-titanium ?= " \
    x4xx_x410_fpga_default \
    x4xx_x440_fpga_default \
    "

DEFAULT_BITFILE_NAME_X410 = "usrp_x410_fpga_X4_200"
DEFAULT_BITFILE_NAME_X440 = "usrp_x440_fpga_X4_400"

UHD_FPGA_IMAGES_IN_FIRMWARE:ni-titanium ?= " \
    ${DEFAULT_BITFILE_NAME_X410} \
    ${DEFAULT_BITFILE_NAME_X440} \
    "

# FPGA_SUBDIRECTORY ??= ""

# do_download_uhd_images:append:ni-titanium() {
#     if [ -n "${EXTERNALSRC}" ]; then
#         ln -sf "${S}/${FPGA_SUBDIRECTORY}/${DEFAULT_BITFILE_NAME_X410}.bit" "${UHD_IMAGES_DOWNLOAD_DIR}/${DEFAULT_BITFILE_NAME_X410}.bit"
#         ln -sf "${S}/${FPGA_SUBDIRECTORY}/${DEFAULT_BITFILE_NAME_X410}.dts" "${UHD_IMAGES_DOWNLOAD_DIR}/${DEFAULT_BITFILE_NAME_X410}.dts"
#         ln -sf "${S}/${FPGA_SUBDIRECTORY}/${DEFAULT_BITFILE_NAME_X440}.bit" "${UHD_IMAGES_DOWNLOAD_DIR}/${DEFAULT_BITFILE_NAME_X440}.bit"
#         ln -sf "${S}/${FPGA_SUBDIRECTORY}/${DEFAULT_BITFILE_NAME_X440}.dts" "${UHD_IMAGES_DOWNLOAD_DIR}/${DEFAULT_BITFILE_NAME_X440}.dts"
#     else
#         python3 ${WORKDIR}/set-symlinks.py -i ${UHD_IMAGES_DOWNLOAD_DIR} -d ${UHD_IMAGES_DOWNLOAD_DIR}
#     fi
# }

do_download_uhd_images:append:ni-titanium() {
    if [ -n "${VITISAIFPGA}" ]; then
        bbwarn "VITISAIFPGA variable found.\nCreating links to: ${VITISAIFPGA}/usrp_x410_fpga_X1_100 outputs\n In: ${UHD_IMAGES_DOWNLOAD_DIR}"
        ln -sf "${VITISAIFPGA}/usrp_x410_fpga_X1_100.bit" "${UHD_IMAGES_DOWNLOAD_DIR}/usrp_x410_fpga_X1_100.bit"
        ln -sf "${VITISAIFPGA}/usrp_x410_fpga_X1_100.dts" "${UHD_IMAGES_DOWNLOAD_DIR}/usrp_x410_fpga_X1_100.dts"
    fi
}

do_install:append:ni-titanium() {
    install -d ${D}/${UHD_IMAGES_INSTALL_PATH}
    install -m 0644 ${UHD_IMAGES_DOWNLOAD_DIR}/usrp_x410_fpga*.* ${D}/${UHD_IMAGES_INSTALL_PATH}
    install -m 0644 ${UHD_IMAGES_DOWNLOAD_DIR}/usrp_x440_fpga*.* ${D}/${UHD_IMAGES_INSTALL_PATH}
    install -m 0644 ${UHD_IMAGES_DOWNLOAD_DIR}/inventory.json    ${D}/${UHD_IMAGES_INSTALL_PATH}

    mv ${D}/lib/firmware/${DEFAULT_BITFILE_NAME_X410}.bin ${D}/lib/firmware/x410.orig.bin
    mv ${D}/lib/firmware/${DEFAULT_BITFILE_NAME_X410}.dtbo ${D}/lib/firmware/x410.orig.dtbo
    mv ${D}/lib/firmware/usrp_x410_fpga_X1_100.bin ${D}/lib/firmware/x410.bin
    mv ${D}/lib/firmware/usrp_x410_fpga_X1_100.dtbo ${D}/lib/firmware/x410.dtbo
    mv ${D}/lib/firmware/${DEFAULT_BITFILE_NAME_X440}.bin ${D}/lib/firmware/x440.bin
    mv ${D}/lib/firmware/${DEFAULT_BITFILE_NAME_X440}.dtbo ${D}/lib/firmware/x440.dtbo
}
