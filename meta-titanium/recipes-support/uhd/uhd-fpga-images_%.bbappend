inherit uhd_images_downloader

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append_ni-titanium = " \
    file://set-symlinks.py \
    "

EXTRA_PACKAGES_ni-titanium ?= " \
    ${PN}-x410 \
    ${PN}-x440 \
    ${PN}-inventory \
    ${PN}-titanium \
    ${PN}-titanium-firmware \
    "

PACKAGES_append_ni-titanium = " \
    ${EXTRA_PACKAGES} \
    ${PN}-x410-firmware \
    ${PN}-x440-firmware \
    "

RDEPENDS_${PN}_ni-titanium = "${EXTRA_PACKAGES}"
RDEPENDS_${PN}-firmware_append_ni-titanium = " \
    ${PN}-x410-firmware \
    ${PN}-x440-firmware \
    "

ALLOW_EMPTY_${PN}-titanium = "1"
RDEPENDS_${PN}-titanium = " \
    ${PN}-x410 \
    ${PN}-x440 \
    "
ALLOW_EMPTY_${PN}-titanium-firmware = "1"
RDEPENDS_${PN}-titanium-firmware = " \
    ${PN}-x410-firmware \
    ${PN}-x440-firmware \
    "

DEFAULT_BITFILE_NAME_X410 = "usrp_x410_fpga_X4_200"
DEFAULT_BITFILE_NAME_X440 = "usrp_x440_fpga_X4_400"

FILES_${PN}-x410 = " \
    ${UHD_IMAGES_INSTALL_PATH}/usrp_x410_fpga*.* \
    "
FILES_${PN}-x440 = " \
    ${UHD_IMAGES_INSTALL_PATH}/usrp_x440_fpga*.* \
    "
FILES_${PN}-inventory = "${UHD_IMAGES_INSTALL_PATH}/inventory.json"
FILES_${PN}-x410-firmware = " \
    /lib/firmware/x410.bin \
    /lib/firmware/x410.dtbo \
    "
FILES_${PN}-x440-firmware = " \
    /lib/firmware/x440.bin \
    /lib/firmware/x440.dtbo \
    "

UHD_IMAGES_TO_DOWNLOAD_ni-titanium ?= " \
    ${@ '' if d.getVar('EXTERNALSRC') else 'x4xx_x410_fpga_default x4xx_x440_fpga_default'} \
    "

UHD_FPGA_IMAGES_IN_FIRMWARE_ni-titanium ?= "${DEFAULT_BITFILE_NAME_X410} ${DEFAULT_BITFILE_NAME_X440}"

UHD_IMAGES_DOWNLOAD_DIR_ni-titanium ?= "${WORKDIR}/uhd-images"

FPGA_SUBDIRECTORY ??= ""

do_download_uhd_images_append_ni-titanium() {
    if [ -n "${EXTERNALSRC}" ]; then
        if [ -h "${UHD_IMAGES_DOWNLOAD_DIR}" ]; then
            bbwarn "removing existing symlink ${UHD_IMAGES_DOWNLOAD_DIR}"
            rm ${UHD_IMAGES_DOWNLOAD_DIR}
        elif [ -d "${UHD_IMAGES_DOWNLOAD_DIR}" ]; then
            bbwarn "removing existing directory ${UHD_IMAGES_DOWNLOAD_DIR}"
            rm -r ${UHD_IMAGES_DOWNLOAD_DIR}
        fi
        bbnote "Setting symlink ${UHD_IMAGES_DOWNLOAD_DIR} -> ${S}/${FPGA_SUBDIRECTORY}"
        ln -s "${S}/${FPGA_SUBDIRECTORY}" "${UHD_IMAGES_DOWNLOAD_DIR}"
        touch ${UHD_IMAGES_DOWNLOAD_DIR}/inventory.json
    else
        python3 ${WORKDIR}/set-symlinks.py -i ${UHD_IMAGES_DOWNLOAD_DIR} -d ${UHD_IMAGES_DOWNLOAD_DIR}
        # as long as no x420 bitfiles are availabe, copy the default x440 bitfile
        for EXT in bit bit.md5 dts dts.md5 rpt; do
            cp ${UHD_IMAGES_DOWNLOAD_DIR}/${DEFAULT_BITFILE_NAME_X440}.$EXT ${UHD_IMAGES_DOWNLOAD_DIR}/${DEFAULT_BITFILE_NAME_X420}.$EXT
        done
    fi
}

do_install_append_ni-titanium() {
    install -d ${D}/${UHD_IMAGES_INSTALL_PATH}
    install -m 0644 ${UHD_IMAGES_DOWNLOAD_DIR}/usrp_x410_fpga*.* ${D}/${UHD_IMAGES_INSTALL_PATH}
    install -m 0644 ${UHD_IMAGES_DOWNLOAD_DIR}/usrp_x440_fpga*.* ${D}/${UHD_IMAGES_INSTALL_PATH}
    install -m 0644 ${UHD_IMAGES_DOWNLOAD_DIR}/inventory.json    ${D}/${UHD_IMAGES_INSTALL_PATH}

    mv ${D}/lib/firmware/${DEFAULT_BITFILE_NAME_X410}.bin ${D}/lib/firmware/x410.bin
    mv ${D}/lib/firmware/${DEFAULT_BITFILE_NAME_X410}.dtbo ${D}/lib/firmware/x410.dtbo
    mv ${D}/lib/firmware/${DEFAULT_BITFILE_NAME_X440}.bin ${D}/lib/firmware/x440.bin
    mv ${D}/lib/firmware/${DEFAULT_BITFILE_NAME_X440}.dtbo ${D}/lib/firmware/x440.dtbo
}
