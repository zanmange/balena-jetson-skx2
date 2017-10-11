inherit kernel-resin deploy

RESIN_CONFIGS_append = " compat"

RESIN_CONFIGS[compat] = " \
    CONFIG_COMPAT=y \
    "

RESIN_CONFIGS_remove = "brcmfmac"

TEGRA_INITRAMFS_INITRD = "0"

KERNEL_ROOTSPEC = "\${resin_kernel_root} ro rootwait" 

generate_extlinux_conf() {
    install -d ${D}/${KERNEL_IMAGEDEST}/extlinux
    rm -f ${D}/${KERNEL_IMAGEDEST}/extlinux/extlinux.conf
    cat >${D}/${KERNEL_IMAGEDEST}/extlinux/extlinux.conf << EOF
DEFAULT primary
TIMEOUT 30
MENU TITLE Boot Options
LABEL primary
      MENU LABEL primary ${KERNEL_IMAGETYPE}
      LINUX /${KERNEL_IMAGETYPE}
      APPEND ${KERNEL_ARGS} ${KERNEL_ROOTSPEC}
EOF
}

do_deploy_append() {
    mkdir -p "${DEPLOYDIR}"
    install -m 0600 "${D}/boot/extlinux/extlinux.conf" "${DEPLOYDIR}"
}
