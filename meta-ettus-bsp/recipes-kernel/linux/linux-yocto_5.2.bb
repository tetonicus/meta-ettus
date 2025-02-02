KBRANCH ?= "v5.2/standard/base"

require recipes-kernel/linux/linux-yocto.inc

# board specific branches
KBRANCH:qemuarm  ?= "v5.2/standard/arm-versatile-926ejs"
KBRANCH:qemuarm64 ?= "v5.2/standard/qemuarm64"
KBRANCH:qemumips ?= "v5.2/standard/mti-malta32"
KBRANCH:qemuppc  ?= "v5.2/standard/qemuppc"
KBRANCH:qemuriscv64  ?= "v5.2/standard/base"
KBRANCH:qemux86  ?= "v5.2/standard/base"
KBRANCH:qemux86-64 ?= "v5.2/standard/base"
KBRANCH:qemumips64 ?= "v5.2/standard/mti-malta64"

SRCREV_machine:qemuarm ?= "ed43b791f2cca6e87928fa47556e540333385187"
SRCREV_machine:qemuarm64 ?= "992280855e88289b7e7019ee2cf9dff867c58b94"
SRCREV_machine:qemumips ?= "5d47f37ab0b7bcd5c0aaf0ecbd6d00bb8a22ddf4"
SRCREV_machine:qemuppc ?= "992280855e88289b7e7019ee2cf9dff867c58b94"
SRCREV_machine:qemuriscv64 ?= "992280855e88289b7e7019ee2cf9dff867c58b94"
SRCREV_machine:qemux86 ?= "992280855e88289b7e7019ee2cf9dff867c58b94"
SRCREV_machine:qemux86-64 ?= "992280855e88289b7e7019ee2cf9dff867c58b94"
SRCREV_machine:qemumips64 ?= "894ee953d9c4036003f41e0800315efe3bab8492"
SRCREV_machine ?= "992280855e88289b7e7019ee2cf9dff867c58b94"
SRCREV_meta ?= "dd6019025cbb701b9818102f267c26e87031a59b"

# remap qemuarm to qemuarma15 for the 5.2 kernel
# Kmachine:qemuarm ?= "qemuarma15"

SRC_URI = "git://git.yoctoproject.org/linux-yocto.git;name=machine;branch=${KBRANCH}; \
           git://git.yoctoproject.org/yocto-kernel-cache;type=kmeta;name=meta;branch=yocto-5.2;destsuffix=${KMETA}"

LIC_FILES_CHKSUM = "file://COPYING;md5=bbea815ee2795b2f4230826c0c6b8814"
LINUX_VERSION ?= "5.2.28"

DEPENDS += "${@bb.utils.contains('ARCH', 'x86', 'elfutils-native', '', d)}"
DEPENDS += "openssl-native util-linux-native"

PV = "${LINUX_VERSION}+git${SRCPV}"

KMETA = "kernel-meta"
KCONF_BSP_AUDIT_LEVEL = "2"

KERNEL_DEVICETREE:qemuarmv5 = "versatile-pb.dtb"

COMPATIBLE_MACHINE = "qemuarm|qemuarmv5|qemuarm64|qemux86|qemuppc|qemumips|qemumips64|qemux86-64|qemuriscv64"

# Functionality flags
KERNEL_EXTRA_FEATURES ?= "features/netfilter/netfilter.scc"
KERNEL_FEATURES:append = " ${KERNEL_EXTRA_FEATURES}"
KERNEL_FEATURES:append:qemuall=" cfg/virtio.scc features/drm-bochs/drm-bochs.scc"
KERNEL_FEATURES:append:qemux86=" cfg/sound.scc cfg/paravirt_kvm.scc"
KERNEL_FEATURES:append:qemux86-64=" cfg/sound.scc cfg/paravirt_kvm.scc"
KERNEL_FEATURES:append = " ${@bb.utils.contains("TUNE_FEATURES", "mx32", " cfg/x32.scc", "" ,d)}"
KERNEL_FEATURES:append = " ${@bb.utils.contains("DISTRO_FEATURES", "ptest", " features/scsi/scsi-debug.scc", "" ,d)}"
