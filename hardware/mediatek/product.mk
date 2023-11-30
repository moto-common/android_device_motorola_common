# Components
TARGET_COMMON_MTK_COMPONENTS := all
include device/mediatek/common/common.mk

# Kernel
## The bootloader will not accept anything but Image.gz
TARGET_KERNEL_IMAGE_NAME := Image.gz

# Hardware
PRODUCT_SOONG_NAMESPACES += hardware/mediatek

# Power
TARGET_USES_PP_HAL := false