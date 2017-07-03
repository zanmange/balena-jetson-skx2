inherit kernel-resin deploy

RESIN_CONFIGS_append = " compat"

RESIN_CONFIGS[compat] = " \
    CONFIG_COMPAT=y \
    "

KERNEL_ARG = "fbcon=map:0 console=tty0 console=ttyS0,115200n8 memtype=0 video=tegrafb no_console_suspend=1 earlycon=uart8250,mmio32,0x03100000 tegraid=18.1.2.0.0 tegra_keep_boot_clocks maxcpus=6 vpr_resize" 
KERNEL_ROOTSPEC = "root=/dev/mmcblk\${devnum}p2 ro rootwait" 

generate_extlinux_conf() {
    install -d ${D}/${KERNEL_IMAGEDEST}/extlinux 
    rm -f ${D}/${KERNEL_IMAGEDEST}/extlinux/extlinux.conf
    cat >${D}/${KERNEL_IMAGEDEST}/extlinux/extlinux.conf << EOF
DEFAULT primary-1
TIMEOUT 30
MENU TITLE Boot Options
EOF
    i=1
    for f in ${KERNEL_DEVICETREE}; do
        fdt=$(basename $f)
        cat >>${D}/${KERNEL_IMAGEDEST}/extlinux/extlinux.conf << EOF
LABEL primary-$i
      MENU LABEL primary-$i ${KERNEL_IMAGETYPE} $fdt
      LINUX /${KERNEL_IMAGETYPE}
      FDT /devicetree-${KERNEL_IMAGETYPE}-$fdt
      APPEND ${KERNEL_ARG} ${KERNEL_ROOTSPEC}
EOF
        i=$(expr $i \+ 1)
    done
} 

do_deploy_append() {
    mkdir -p "${DEPLOYDIR}"
    install -m 0600 "${D}/boot/extlinux/extlinux.conf" "${DEPLOYDIR}"
}
