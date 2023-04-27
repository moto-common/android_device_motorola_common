# Display
-include vendor/qcom/opensource/display/$(qcom_platform)/config/display-board.mk

# GPS
TARGET_USES_HARDWARE_QCOM_GPS := false

# Kernel
BOARD_KERNEL_CMDLINE += \
    androidboot.console=ttyMSM0 \
    androidboot.hardware=qcom \
    service_locator.enable=1

# Media
TARGET_USES_ION := true

# QCOM Common Board Hook
ifneq ($(ROM_INCLUDES_QCOM_COMMON),true)
    include device/motorola/common/hardware/qcom/utils.mk
    include device/qcom/common/BoardConfigQcom.mk
endif
