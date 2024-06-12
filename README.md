meta-ettus
==========

This repository contains various layers for different NI (Ettus Research) Products

Supported devices
=================

  - NI USRP X410/X440 series (meta-titanium)
  - NI USRP N310/N300 series (meta-sulfur)
  - NI USRP E320 series (meta-neon)
  - NI USRP E310/E312/E313 (meta-e31x)


Repository organization
=======================

The repository is split into several sublayers to allow for greater modularity.

**meta-alchemy:**

- Contains common distro configuration

**meta-ettus-bsp:**

- Contains the board support package (BSP) including machine configurations and
  bootloader / kernel recipes enabling the device to boot.
- The following machines are supported:
  - E310/E312/E313: [ni-e31x-sg1](meta-ettus-bsp/conf/machine/ni-e31x-sg1.conf),
    [ni-e31x-sg3](meta-ettus-bsp/conf/machine/ni-e31x-sg3.conf)
  - E320: [ni-neon-rev2](meta-ettus-bsp/conf/machine/ni-neon-rev2.conf) (and previous HW revision 1)
  - N3XX: [ni-sulfur-rev11](meta-ettus-bsp/conf/machine/ni-sulfur-rev11.conf) (and previous HW revisions)
  - X4XX: [ni-titanium-rev5](meta-ettus-bsp/conf/machine/ni-titanium-rev5.conf) (and previous HW revisions)

**meta-ettus-core:**

- Contains common core recipes, such as the [developer-image](meta-ettus-core/recipes-core/images/developer-image.bb) or [gnuradio-image](meta-ettus-core/recipes-core/images/gnuradio-image.bb)

**meta-e31x:**

- Contains recipe extensions for full UHD/MPM support on E310/E312/E313

**meta-mender-e31x:**

- Contains changes for E310/E312/E313 mender.io integration.
- E.g. it defines the machines [ni-e31x-sg1-mender](meta-mender-e31x/conf/machine/ni-e31x-sg1-mender.conf) and [ni-e31x-sg3-mender](meta-mender-e31x/conf/machine/ni-e31x-sg3-mender.conf)

**meta-neon:**

- Contains recipe extensions for full UHD/MPM support on E320

**meta-mender-neon:**

- Contains changes for E320 mender.io integration.
- Defines new machines such as [ni-neon-rev2-mender](meta-mender-neon/conf/machine/ni-neon-rev2-mender.conf) to build with mender.io integration.

**meta-sulfur:**

- Contains recipe extensions for full UHD/MPM support on N310/N300/N320

**meta-mender-sulfur:**

- Contains changes for N310/N300 mender.io integration.
- Defines new machines such as [ni-sulfur-rev11-mender](meta-mender-sulfur/conf/machine/ni-sulfur-rev11-mender.conf) to build with mender.io integration.

**meta-titanium**:

- Contains recipe extensions for full UHD/MPM support on X410/X440

**meta-mender-titanium**:

- Contains changes for X410/X440 mender.io integration
- Defines new machines such as [ni-titanium-rev5-mender](meta-mender-titanium/conf/machine/ni-titanium-rev5-mender.conf) to build with mender.io integration.

Building an Image using the kas image builder script
====================================================

This repository provides a script that can be used to build filesystem images
for the various supported USRP devices. The script relies on [kas](https://github.com/siemens/kas) which
orchestrates environment and dependency setup for building the images.

We recommend building USRP images with the offical kas docker images. You can
get those [here](https://ghcr.io/siemens/kas/kas).

From the top level of this repository, run ``./contrib/kas_build_imgs_package.sh``
without arguments to get the help message of this script.

Run the script, e.g., for the N310:

    ./meta-ettus/contrib/kas_build_imgs_package.sh n3xx v4.7.0.0

This will setup the environment, build, and zip up the filesystem image,
the SDK, and the Mender artifact.

Building an Image using the Alchemy distro and kas
==================================================

We recommend building USRP images with the offical kas docker images. You can
get those [here](https://ghcr.io/siemens/kas/kas) or use
[kas-container](https://github.com/siemens/kas/blob/master/kas-container),
which helps automate the container.

To build an image with kas, call

    kas build ./kas/configs-mender/[devicename].yml

The yml files define properties and dependencies for the images. You can override
these by setting environment variables. For example, you can change the mender
image name that appears when calling ``mender show-artifact`` by
setting the `MENDER_ARTIFACT_NAME` environment variable:

    export MENDER_ARTIFACT_NAME=Custom_Artifact_Name
    kas build ./kas/configs-mender/[devicename].yml

Specifying the UHD version to use
=================================

The repository contains different recipes for building different versions of
UHD, see the recipe files in [meta-ettus-core/recipes-support/uhd](meta-ettus-core/recipes-support/uhd).

You can specify the UHD version to use by setting the variable
PREFERRED_UHD_VERSION in the [/kas/include/base-mender.yml](kas/include/base-mender.yml) env section.
Example for forcing UHD 4.7:

    PREFERRED_UHD_VERSION: "4.7%"

Please note the '%' symbol at the end which is used to match any 4.7 version
(e.g. 4.7.0.0+gitGITHASH).

The [Alchemy.conf](meta-alchemy/conf/distro/Alchemy.conf) file will automatically
set the appropriate versions for the uhd, uhd-fpga-images and mpmd recipes:

    PREFERRED_VERSION_uhd ?= "${PREFERRED_UHD_VERSION}"
    PREFERRED_VERSION_uhd-fpga-images ?= "${PREFERRED_UHD_VERSION}"
    PREFERRED_VERSION_mpmd ?= "${PREFERRED_UHD_VERSION}"

The default value for PREFERRED_UHD_VERSION is also set in the Alchemy.conf
file. It is set to the latest released version of UHD per default.
