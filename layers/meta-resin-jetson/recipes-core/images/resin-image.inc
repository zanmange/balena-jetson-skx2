IMAGE_FSTYPES_append = " resinos-img"

RESIN_BOOT_PARTITION_FILES = " \
    ${KERNEL_IMAGETYPE}${KERNEL_INITRAMFS}-${MACHINE}.bin:/${KERNEL_IMAGETYPE} \
    "

# We chose this value so that the space resinOS takes will amount to 1GiB
IMAGE_ROOTFS_SIZE = "487424" 
RESIN_BOOT_SIZE = "80960"
                                                                                                                                                                            
PARTITION_TABLE_TYPE = "gpt"

IMAGE_INSTALL_append = " tegra186-flash-dry"

# kernel-image is installed by meta-tegra. We use kernel-image-initramfs
# Remove kernel-image package
MACHINE_ESSENTIAL_EXTRA_RDEPENDS_remove = "kernel-image"
