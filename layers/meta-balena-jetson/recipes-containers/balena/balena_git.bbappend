FILES_COMPRESS=""

FILESEXTRAPATHS_append := ":${THISDIR}/files"

SRC_URI_append = " file://balena-healthcheck-image-load.service"

SYSTEMD_SERVICE_${PN} += " balena-healthcheck-image-load.service"

do_install_prepend(){
    install -d ${D}${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/balena-healthcheck-image-load.service ${D}/${systemd_unitdir}/system

    # A separate service file will start the healthcheck service.
    # TODO: Remove this workaround when a fix is merged in Balena
    sed -i 's/ExecStartPost=/#ExecStartPost=/g' ${WORKDIR}/balena.service
}
