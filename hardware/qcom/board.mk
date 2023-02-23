# Display
include vendor/qcom/opensource/display/$(qcom_platform)/config/display-board.mk

# QCOM Common Board Hook
ifneq ($(ROM_INCLUDES_QCOM_COMMON),true)
    include device/qcom/common/BoardConfigQcom.mk
endif
