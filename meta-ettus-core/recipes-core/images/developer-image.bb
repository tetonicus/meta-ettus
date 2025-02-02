SUMMARY = "A console-only image with a development/debug \
environment."

require default-packages.inc

IMAGE_FEATURES += "splash ssh-server-openssh tools-sdk \
                   debug-tweaks \
                  "

EXTRA_IMAGE_FEATURES += "package-management"

IMAGE_INSTALL += "mpmd-dev uhd-dev"

LICENSE = "MIT"

inherit core-image image-buildinfo
TOOLCHAIN_HOST_TASK += "nativesdk-python3-setuptools \
                        nativesdk-python3-mako \
                       "
