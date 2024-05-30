do_configure:prepend() {
    echo "RuntimeWatchdogSec=10" >> ${WORKDIR}/system.conf
}
