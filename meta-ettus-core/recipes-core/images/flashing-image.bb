SUMMARY = "minimal image which provides bmap-tools for flashing"
LICENSE = "MIT"

inherit core-image

IMAGE_FEATURES += "debug-tweaks"
IMAGE_INSTALL += "bmap-tools util-linux-lsblk gzip xz"
