IMAGE_FSTYPES_append = " resinos-img"

RESIN_BOOT_PARTITION_FILES = " \                                                                                                                                                                            
    ${KERNEL_IMAGETYPE}${KERNEL_INITRAMFS}-${MACHINE}.bin:/${KERNEL_IMAGETYPE} \                                                                                                                       
    ${DTB_FILES} \                                                                                                                                                                                          
    extlinux.conf:/extlinux/extlinux.conf \                                                                                                                                                            
    "                                                                                                                                                                                                       
                                                                                                                                                                                                            
# We chose this value so that the space resinOS takes will amount to 1GiB
IMAGE_ROOTFS_SIZE = "487424" 
                                                                                                                                                                            
python__anonymous() {                                                                                                                                                                                       
    import re                                                                                                                                                                                               
                                                                                                                                                                                                            
    dtb_files = ""                                                                                                                                                                                          
                                                                                                                                                                                                            
    for dtb in d.getVar('KERNEL_DEVICETREE', True).split():                                                                                                                                                 
        dtb_basename = os.path.basename(os.path.splitext(dtb)[0])                                                                                                                                           
        dtb_ext =  os.path.splitext(dtb)[1]                                                                                                                                                                 
        symlink_name = d.getVar('KERNEL_IMAGETYPE', True) + "-" + dtb_basename + dtb_ext                                                                                                                    
        dtb_files += "\t%s:/%s" %(symlink_name, "devicetree-" + d.getVar('KERNEL_IMAGETYPE', True) + "-" + os.path.basename(dtb))                                                                      
                                                                                                                                                                                                            
    d.setVar('DTB_FILES', dtb_files)                                                                                                                                                                        
}

PARTITION_TABLE_TYPE = "gpt"
DEVICE_SPECIFIC_SPACE = "49152"

IMAGE_DEPENDS_resinos-img_append = " tegra-binaries-prepare:do_deploy"

device_specific_configuration() {
    DEPLOYDIR="${TMPDIR}/deploy/images/${MACHINE}"

    partitions="mts-bootpack:${DEPLOYDIR}/tegra-binaries-signed/mce_mts_d15_prod_cr_sigheader.bin.encrypt \
                cpu-bootloader:${DEPLOYDIR}/tegra-binaries-signed/cboot_sigheader.bin.encrypt \
                bootloader-dtb:${DEPLOYDIR}/tegra-binaries-signed/tegra186-quill-p3310-1000-c03-00-base_sigheader.dtb.encrypt \
                secure-os:${DEPLOYDIR}/tegra-binaries-signed/tos_sigheader.img.encrypt \
                eks:${DEPLOYDIR}/tegra-binaries-signed/eks_sigheader.img.encrypt \
                bpmp-fw:${DEPLOYDIR}/tegra-binaries-signed/bpmp_sigheader.bin.encrypt \
                bpmp-fw-dtb:${DEPLOYDIR}/tegra-binaries-signed/tegra186-a02-bpmp-quill-p3310-1000-c01-00-te770d-ucm2_sigheader.dtb.encrypt \
                sce-fw:${DEPLOYDIR}/tegra-binaries-signed/camera-rtcpu-sce_sigheader.bin.encrypt \
                sc7:${DEPLOYDIR}/tegra-binaries-signed/warmboot_wbheader.bin.encrypt \
                kernel:${DEPLOYDIR}/u-boot-jetson-tx2.bin \
                kernel-dtb:${DEPLOYDIR}/Image-tegra186-quill-p3310-1000-c03-00-base.dtb"

    START=${RESIN_IMAGE_ALIGNMENT}
    for n in ${partitions}; do
      END=$(expr ${START} \+ ${RESIN_IMAGE_ALIGNMENT})
      parted -s ${RESIN_RAW_IMG} unit KiB mkpart $(echo $n | cut -d ':' -f 1) ${START} ${END}
      dd if=$(echo $n | cut -d ':' -f 2) of=${RESIN_RAW_IMG} conv=notrunc seek=1 bs=$(expr 1024 \* ${START})
      START=${END}
    done
}
