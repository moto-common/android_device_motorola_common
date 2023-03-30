# Display
-include vendor/qcom/opensource/display/$(qcom_platform)/config/display-board.mk

# Media
TARGET_USES_ION := true

# QCOM Common Board Hook
ifneq ($(ROM_INCLUDES_QCOM_COMMON),true)
    include device/motorola/common/hardware/qcom/utils.mk
    include device/qcom/common/BoardConfigQcom.mk
endif
