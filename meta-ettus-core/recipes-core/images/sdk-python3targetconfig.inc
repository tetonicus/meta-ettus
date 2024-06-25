inherit python3-dir

sdk_python3targetconfig () {
    cp -v ${SDK_OUTPUT}/${SDKTARGETSYSROOT}${libdir}/${PYTHON_DIR}/_sysconfigdata*.py ${SDK_OUTPUT}/${SDKPATHNATIVE}${libdir}/${PYTHON_DIR}/_sysconfigdata.py
    echo "export _PYTHON_SYSCONFIGDATA_NAME=\"_sysconfigdata\"" > ${SDK_OUTPUT}/${SDKPATHNATIVE}/environment-setup.d/python3targetconfig.sh
}

SDK_POSTPROCESS_COMMAND:prepend = "sdk_python3targetconfig; "
