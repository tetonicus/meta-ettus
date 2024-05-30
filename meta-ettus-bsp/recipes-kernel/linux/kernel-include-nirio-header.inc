# Include the nirio.h header in the sysroot and final package
# TODO: Investigate using https://bugzilla.yoctoproject.org/show_bug.cgi?id=5305 instead

PACKAGES:append = " ${KERNEL_PACKAGE_NAME}-headers"
FILES:${KERNEL_PACKAGE_NAME}-headers += "${exec_prefix}/include/misc/nirio.h"

do_install:append () {
	install -d ${D}${exec_prefix}/include/misc
	find ${STAGING_KERNEL_DIR}/ -name nirio.h -exec cp {} ${D}${exec_prefix}/include/misc \;
}

sysroot_stage_all:append () {
	sysroot_stage_dir ${D}${exec_prefix}/include ${SYSROOT_DESTDIR}${exec_prefix}/include
}
