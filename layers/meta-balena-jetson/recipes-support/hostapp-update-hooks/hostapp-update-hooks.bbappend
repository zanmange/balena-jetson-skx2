FILESEXTRAPATHS_append := ":${THISDIR}/files"

DEPENDS_${PN}_append = " tegra186-flash-dry"

HOSTAPP_HOOKS_append = " 99-resin-uboot 50-tx2-update"

do_install_append() {
    install -m 0755 ${WORKDIR}/50-tx2-update ${D}${sysconfdir}/hostapp-update-hooks.d/
}
