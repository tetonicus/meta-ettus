DESCRIPTION = "unittest-based test runner with Ant/JUnit like XML reporting"
HOMEPAGE = "https://github.com/xmlrunner/unittest-xml-reporting"
SECTION = "devel/python"

LICENSE = "BSD-2-Clause"
LIC_FILES_CHKSUM = "file://LICENSE;md5=9c1704dc0195927babb794492a2a442d"

PYPI_PACKAGE := "unittest-xml-reporting"

inherit pypi

SRC_URI[md5sum] = "f12aeab63ff44e295526e103313d66c8"
SRC_URI[sha256sum] = "edd8d3170b40c3a81b8cf910f46c6a304ae2847ec01036d02e9c0f9b85762d28"

SRC_URI += "file://0001-Don-t-install-LICENSE-to-usr.patch"

BBCLASSEXTEND = "native"

RDEPENDS:${PN} = " \
    ${PYTHON_PN}-core \
    ${PYTHON_PN}-six \
    "

RPROVIDES:${PN} = " \
    ${PYTHON_PN}-xmlrunner"
