FILESEXTRAPATHS_append := ":${THISDIR}/${PN}"

inherit allarch systemd

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI += " \
    file://99-nv-wifibt.rules \
    file://nvwifibt-unblock.service \
"

FILES_${PN} = " \
    /lib/udev/rules.d/99-nv-wifibt.rules \
    /lib/systemd/system/nvwifibt-unblock.service \
"

SYSTEMD_SERVICE_${PN} = "nvwifibt-unblock.service"

RDEPENDS_${PN} = " bash systemd"

do_install_append() {
    install -d ${D}/${systemd_unitdir}/system
    install -d ${D}/${base_libdir}/udev/rules.d
    install -m 644 ${WORKDIR}/99-nv-wifibt.rules ${D}/${base_libdir}/udev/rules.d
    install -m 644 ${WORKDIR}/nvwifibt-unblock.service ${D}/${systemd_unitdir}/system
}

COMPATIBLE_MACHINE="jetson-tx2"
