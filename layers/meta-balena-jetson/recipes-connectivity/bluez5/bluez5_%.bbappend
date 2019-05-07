FILESEXTRAPATHS_append := ":${THISDIR}/files"

inherit systemd

SRC_URI += " \
        file://hciattach.service \
        "

SYSTEMD_SERVICE_${PN} = "hciattach.service"

do_install_append() {
        install -d ${D}/${systemd_unitdir}/system
        install -m 644 ${WORKDIR}/hciattach.service ${D}/${systemd_unitdir}/system
}
