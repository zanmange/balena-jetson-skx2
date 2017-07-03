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

# XXX The BSP does not provide a bootloader for this board
RESIN_IMAGE_BOOTLOADER = ""
