SUMMARY = "A console-only image with a development/debug \
environment and also GNURadio installed."

require default-packages.inc vitis-ai-packages.inc

IMAGE_FEATURES += "splash ssh-server-openssh tools-sdk \
                   debug-tweaks \
                  "

EXTRA_IMAGE_FEATURES += "package-management"

LICENSE = "MIT"

IMAGE_INSTALL += " \
    ${CORE_IMAGE_BASE_INSTALL} \
    python3-pybind11 \
    packagegroup-sdr-python-extended \
    packagegroup-sdr-gnuradio-base \
    ${@bb.utils.contains('DISTRO_FEATURES', 'x11', 'xauth', '', d)} \
    uhd-dev \
    mpmd-dev \
    packagegroup-sdr-python-extended-dev \
    packagegroup-sdr-gnuradio-base-dev \
    "

inherit core-image image-buildinfo
TOOLCHAIN_HOST_TASK += "nativesdk-python3-setuptools \
                        nativesdk-python3-mako \
                       "
