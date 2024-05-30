SYSROOT_DIRS:append:class-target = " ${bindir}"

sysroot_stage_all:append:class-target() {
  if [ -e "${SYSROOT_DESTDIR}${bindir}" ]; then
      mv ${SYSROOT_DESTDIR}${bindir} ${SYSROOT_DESTDIR}${bindir}-${PN}
      mkdir ${SYSROOT_DESTDIR}${bindir}
      mv ${SYSROOT_DESTDIR}${bindir}-${PN} ${SYSROOT_DESTDIR}${bindir}/${PN}
  fi
}
