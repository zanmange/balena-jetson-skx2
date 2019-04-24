#!/bin/sh

BPFDTB_FILE="tegra186-a02-bpmp-quill-p3310-1000-@REV@-00-te770d-ucm2.dtb"
PINMUX_CONFIG="tegra186-mb1-bct-pinmux-quill-p3310-1000-@REV@.cfg"
PMIC_CONFIG="tegra186-mb1-bct-pmic-quill-p3310-1000-@REV@.cfg"
PMC_CONFIG="tegra186-mb1-bct-pad-quill-p3310-1000-@REV@.cfg"
PROD_CONFIG="tegra186-mb1-bct-prod-quill-p3310-1000-@REV@.cfg"
BOOTROM_CONFIG="tegra186-mb1-bct-bootrom-quill-p3310-1000-@REV@.cfg"


# The following defaults are for the B00 revision SOM
# which shipped with at least some Jetson TX2 dev kits.
# BOARDREV is used for all substitutions, except for
# BPFDTB and PMIC revisions, which differe between B00
# and B01 revisions.  See p2771-0000.conf.common in
# the L4T kit.
BOARDREV="c03"
BPFDTBREV="c04"
PMICREV="c03"

BPFDTB_FILE=`echo $BPFDTB_FILE | sed -e"s,@REV@,$BPFDTBREV,"`
sed -e"s,BPFDTB-FILE,$BPFDTB_FILE," \
    "flash.xml.in" > flash.xml

PINMUX_CONFIG=`echo $PINMUX_CONFIG | sed -e"s,@REV@,$BOARDREV,"`
PMIC_CONFIG=`echo $PMIC_CONFIG | sed -e"s,@REV@,$PMICREV,"`
PMC_CONFIG=`echo $PMC_CONFIG | sed -e"s,@REV@,$BOARDREV,"`
PROD_CONFIG=`echo $PROD_CONFIG | sed -e"s,@REV@,$BOARDREV,"`
BOOTROM_CONFIG=`echo $BOOTROM_CONFIG | sed -e"s,@REV@,$BOARDREV,"`

BINS="mb2_bootloader nvtboot_recovery.bin; \
mts_preboot preboot_d15_prod_cr.bin; \
mts_bootpack mce_mts_d15_prod_cr.bin; \
bpmp_fw bpmp.bin; \
bpmp_fw_dtb $BPFDTB_FILE; \
tlk tos.img; \
eks eks.img; \
bootloader_dtb ${DTBFILE}"
