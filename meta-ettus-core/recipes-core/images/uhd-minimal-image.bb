SUMMARY = "minimal image with UHD"
LICENSE = "MIT"

inherit core-image

IMAGE_INSTALL += "uhd"
IMAGE_FEATURES = "debug-tweaks"
