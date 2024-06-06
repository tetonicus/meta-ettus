FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:ni-e31x = " file://0001-gr-uhd-remove-inclusion-of-ReplayMsgPushButton.patch"
SRC_URI:append:ni-neon = " file://0001-gr-uhd-remove-inclusion-of-ReplayMsgPushButton.patch"
SRC_URI:append:ni-sulfur = " file://0001-gr-uhd-remove-inclusion-of-ReplayMsgPushButton.patch"
SRC_URI:append:ni-titanium = " file://0001-gr-uhd-remove-inclusion-of-ReplayMsgPushButton.patch"
