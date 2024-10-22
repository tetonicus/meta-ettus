# DEPENDS += "python3-six-native"

IMAGE_INSTALL += "\
    ${CORE_IMAGE_BASE_INSTALL} \
    graphviz \
    resnet50 \
    dpu-sw-optimize \
    target-factory \
    vitis-ai-library \
    vitis-ai-library-dbg \
    vitis-ai-library-dev \
    "
