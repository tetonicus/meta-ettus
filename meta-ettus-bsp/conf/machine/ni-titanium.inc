PREFERRED_PROVIDER_virtual/kernel ?= "linux-x4xx"

require conf/machine/ni-zynqmp.inc
require conf/machine/include/arm/armv8a/tune-cortexa53.inc

MACHINEOVERRIDES = "zynqmp:ni-titanium:${MACHINE}"
MACHINE_FEATURES = "rtc ethernet ext2 ext3 vfat usbhost"

PREFERRED_PROVIDER_virtual/bootloader = "u-boot"

UBOOT_SUFFIX:zynqmp ?= "itb"
UBOOT_BINARY ?= "u-boot.${UBOOT_SUFFIX}"
UBOOT_ELF:aarch64 ?= "u-boot.elf"

UBOOT_LOADADDRESS = "0x200000"
UBOOT_ENTRYPOINT = "0x200000"
UBOOT_DTB_LOADADDRESS = "0x70000"
UBOOT_DTBO_LOADADDRESS = "0x79000"

SPL_BINARY ?= "spl/boot.bin"
PREFERRED_VERSION_u-boot ?= "2020.10"

SERIAL_CONSOLES ?= "115200;ttyPS0"
SERIAL_CONSOLES_CHECK ?= "${SERIAL_CONSOLES}"

KERNEL_DEVICETREE:ni-titanium ?= "\
	ni/x410-rev2.dtb \
	ni/x410-rev3.dtb \
	ni/x410-rev4.dtb \
	ni/x410-rev5.dtb \
	ni/x410-rev6.dtb \
	ni/x410-rev7.dtb \
	ni/x4xx-db0-0x4001-rev1.dtbo \
	ni/x4xx-db1-0x4001-rev1.dtbo \
	ni/x4xx-dioaux-0x4003-rev1.dtbo \
	ni/x4xx-clkaux-0x4004-rev1.dtbo \
	ni/x4xx-clkaux-0x4005-rev1.dtbo \
	ni/x4xx-clkaux-0x4004-rev2.dtbo \
	ni/x4xx-clkaux-0x4005-rev2.dtbo \
	ni/x4xx-db0-0x4006-rev1.dtbo \
	ni/x4xx-db1-0x4006-rev1.dtbo \
	ni/x4xx-db0-db-flash.dtbo \
	ni/x4xx-db1-db-flash.dtbo \
"
FIT_CONF_PREFIX = "conf@"

IMAGE_BOOT_FILES ?= "boot.bin ${UBOOT_BINARY}"
PMU_FIRMWARE_DEPLOY_DIR ?= "${TOPDIR}/tmp-xilinx/deploy/images/zynqmp-pmu"
PMU_FIRMWARE_IMAGE_NAME ?= "pmu-firmware-zynqmp-pmu"

KERNEL_CLASSES += "kernel-fitimage"
KERNEL_IMAGETYPE = "fitImage"
INITRAMFS_IMAGE = "manufacturing-image"
# INITRAMFS_IMAGE_BUNDLE = "1"

MACHINE_ESSENTIAL_EXTRA_RDEPENDS += " \
                             kernel-image \
                             kernel-devicetree \
                             watchdog \
                             usrp-firmware \
                            "

MACHINE_ESSENTIAL_EXTRA_RRECOMMENDS = " \
                             kernel-image \
                             kernel-devicetree \
                             kernel-modules \
                             usrp-firmware \
          "

MACHINE_EXTRA_RRECOMMENDS = " \
                             eeprom-hostname-systemd \
                             gpsd-machine-conf \
                             haveged \
                             ledctrl \
			     mmc-utils \
			     uhd-cpld-images \
          "

do_image_wic[depends] += " \
    u-boot:do_deploy \
    "

IMAGE_FSTYPES += "${@bb.utils.contains('MENDER_FEATURES', 'mender-image-sd', '', ' wic.xz wic.bmap', d)} tar.xz"
