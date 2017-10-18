include resin-image.inc

IMAGE_FSTYPES_append = " hostapp-ext4"

IMAGE_INSTALL_append = " tegra-binaries-prepare"

RESIN_BOOT_PARTITION_FILES_append  = " extlinux.conf:/extlinux/extlinux.conf"
