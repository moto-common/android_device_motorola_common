# Display
-include vendor/qcom/opensource/display/$(qcom_platform)/config/display-board.mk

# GPS
TARGET_USES_HARDWARE_QCOM_GPS := false

# Kernel
BOARD_KERNEL_CMDLINE += \
    androidboot.console=ttyMSM0 \
    androidboot.hardware=qcom \
    service_locator.enable=1

TARGET_COMPILE_WITH_MSM_KERNEL := true

# Media
TARGET_USES_ION := true

# QCOM Common Board Hook
ifneq ($(ROM_INCLUDES_QCOM_COMMON),true)
    include device/motorola/common/hardware/qcom/utils.mk
    include device/qcom/common/BoardConfigQcom.mk
endif

# Recovery
## Configure recovery updater library
ifeq ($(call device-has-characteristic,ufs),true)
  ifeq ($(call is-kernel-greater-than-or-equal-to,5.4),true)
    SOONG_CONFIG_NAMESPACES += ufsbsg
    SOONG_CONFIG_ufsbsg := ufsframework
    SOONG_CONFIG_ufsbsg_ufsframework := bsg
  endif
endif
