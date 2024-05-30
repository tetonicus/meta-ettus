SUMMARY = "NI FPGA Interface Python API"
HOMEPAGE = "https://github.com/ni/nifpga-python"
SECTION = "devel/python"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=8275bea59423b927c5ea127b830bf491"

PV = "22.0.0+git${SRCPV}"
SRCREV = "0e5731955c2a4b5e9fe238edb25bab1797f5ed57"
SRC_URI = " \
    git://github.com/ni/nifpga-python;protocol=https;branch=master \
    "

S = "${WORKDIR}/git"

RDEPENDS:${PN} = " \
    ${PYTHON_PN}-future \
    "

inherit setuptools3
