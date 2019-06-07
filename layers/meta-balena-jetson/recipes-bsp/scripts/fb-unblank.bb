FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

DESCRIPTION = "Package used to work around consoleblank=0 turning screen off from startup"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit allarch systemd

SRC_URI = " file://fb-unblank.service"

RDEPENDS_${PN} = " bash systemd"

do_install () {
    install -d ${D}/${systemd_unitdir}/system
    install -m 0755 ${WORKDIR}/fb-unblank.service ${D}/${systemd_unitdir}/system/fb-unblank.service
}

SYSTEMD_SERVICE_${PN} = "fb-unblank.service"

COMPATIBLE_MACHINE = "jetson-tx2"
