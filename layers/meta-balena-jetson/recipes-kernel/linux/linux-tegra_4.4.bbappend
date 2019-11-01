inherit kernel-resin

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append = " \
	file://realsense_hid_linux-yocto_4.4.patch \
	file://realsense_metadata_linux-yocto_4.4.patch \
	file://realsense_powerlinefrequency_control_fix_linux-yocto_4.4.patch \
	file://realsense_camera_formats_linux-yocto_4.4.patch \
	file://realsense_format_desc_4.4.patch \
	file://0001-Backport-qmi_wwan-from-kernel-4.14-to-4.4.patch \
	file://0003-m_ttcan.c-Rename-to-m_ttcan_ext.c.patch \
        file://0001-Logging-fixdep.patch \
	"

RESIN_CONFIGS_append = " uvc"

RESIN_CONFIGS[uvc] = " \
		CONFIG_USB_VIDEO_CLASS=m \
		CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV=y \
		"

RESIN_CONFIGS_DEPS[uvc] = " \
		CONFIG_MEDIA_CAMERA_SUPPORT=y \
		CONFIG_VIDEO_V4L2_SUBDEV_API=y \
		CONFIG_VIDEO_V4L2=m \
		CONFIG_VIDEOBUF2_CORE=m \
		CONFIG_VIDEOBUF2_MEMOPS=m \
		CONFIG_VIDEOBUF2_VMALLOC=m \
		CONFIG_MEDIA_USB_SUPPORT=y \
		CONFIG_USB_GSPCA=m \
		CONFIG_SND_USB=y \
		CONFIG_SND_USB_AUDIO=m \
		"

RESIN_CONFIGS_append = " egalax"

RESIN_CONFIGS[egalax] = " \
		CONFIG_TOUCHSCREEN_EGALAX=m \
		"

RESIN_CONFIGS_append = " serial"
RESIN_CONFIGS[serial] = " \
		CONFIG_USB_SERIAL_GENERIC=y \
		"
