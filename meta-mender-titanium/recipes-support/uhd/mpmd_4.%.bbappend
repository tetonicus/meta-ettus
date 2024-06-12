inherit mender-state-scripts

SRC_URI:append:ni-titanium-mender = " \
    file://copy-int0-interface.sh \
    "
FILES:${PN}:append:ni-titanium-mender = " /data/network/*"

do_compile:append:ni-titanium-mender() {
    # install copy-int0-interface script to update /data/int0.network
    mkdir -p ${MENDER_STATE_SCRIPTS_DIR}
    cp ${WORKDIR}/copy-int0-interface.sh ${MENDER_STATE_SCRIPTS_DIR}/ArtifactCommit_Enter_10_copy-int0-interface
}

do_install:append:ni-titanium-mender() {
    install -d ${D}/data/network/
    for FILENAME in ${D}${base_libdir}/systemd/network/*; do
        # When installing the .network files, "40-" is prepended by mpmd.inc
        # rename the file back (e.g. "40-eth0.network" to "eth0.network")
        # when creating the symlink target at /data/network
        NEW_BASENAME=$(echo "$(basename $FILENAME)" | sed "s|^40-||")
        cp $FILENAME ${D}/data/network/$NEW_BASENAME
        mv $FILENAME $FILENAME.sample
        ln -s /data/network/$NEW_BASENAME $FILENAME
    done
}

pkg_postinst_ontarget:${PN}() {
    for FILENAME in ${base_libdir}/systemd/network/*.network; do
        if [ -h $FILENAME ] && [ ! -e $FILENAME ]; then
            echo "File $FILENAME is not existing, copying .sample file"
            install -D $FILENAME.sample $(readlink $FILENAME)
        fi
    done
}
