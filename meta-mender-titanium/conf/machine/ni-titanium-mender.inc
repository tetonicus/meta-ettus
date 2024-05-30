MACHINEOVERRIDES =. "ni-titanium-mender:"

MENDER_FEATURES_ENABLE:append:ni-titanium-mender = " mender-uboot mender-image \
    mender-image-sd mender-systemd mender-client-install"
MENDER_FEATURES_DISABLE:append:ni-titanium-mender = " mender-grub mender-image-uefi"

IMAGE_FSTYPES:remove:ni-titanium-mender = "wic wic.bmap"

PREFERRED_VERSION_pn-mender-client = "2.%"
PREFERRED_VERSION_pn-mender-artifact = "3.%"
PREFERRED_VERSION_pn-mender-artifact-native = "3.%"

IMAGE_INSTALL:append = " mender-client-migrate-configuration"
PACKAGECONFIG:remove = "split-mender-config"
MENDER_PERSISTENT_CONFIGURATION_VARS = "RootfsPartA RootfsPartB"
# MENDER_ARTIFACT_EXTRA_ARGS:append = " -v 2"

MENDER_DATA_PART_FSTAB_OPTS ?= "defaults,noatime"
MENDER_BOOT_PART_FSTAB_OPTS ?= "defaults,noatime"
