FILES:${PN}:append:ni-sulfur-mender = " /data/network/*"

do_install:append:ni-sulfur-mender() {
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
    # force overwriting int0.network file
    for FILENAME in ${base_libdir}/systemd/network/*int0.network; do
        echo "Overwriting $FILENAME file"
        install -D -v $FILENAME.sample $(readlink $FILENAME)
    done
    if [ -x /bin/systemctl ]; then /bin/systemctl reload --no-block systemd-networkd; fi
}
