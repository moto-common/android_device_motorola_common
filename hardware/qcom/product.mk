# QCOM Platform selector
ifeq ($(TARGET_KERNEL_VERSION), 5.4)
    qcom_platform := sm8350
else ifeq ($(TARGET_KERNEL_VERSION), 4.19)
    qcom_platform := sm8250
else
    qcom_platform := sm8150
endif

# Audio
$(call inherit-product-if-exists, vendor/qcom/opensource/audio/$(qcom_platform)/configs/$(TARGET_BOARD_PLATFORM)/$(TARGET_BOARD_PLATFORM).mk)

# Components
TARGET_COMMON_QTI_COMPONENTS := \
    adreno \
    audio \
    av \
    charging \
    display \
    dsprpcd \
    init \
    keymaster \
    media \
    neuralnetworks \
    overlay \
    qseecomd \
    vibrator \
    wlan

# Display
$(call inherit-product-if-exists, vendor/qcom/opensource/display/$(qcom_platform)/config/display-product.mk)
$(call inherit-product-if-exists, vendor/qcom/opensource/display-commonsys-intf/config/display-interfaces-product.mk)

# Media
$(call inherit-product-if-exists, vendor/qcom/opensource/media/$(qcom_platform)/product.mk)

# QCOM Common Product Hook
ifneq ($(ROM_INCLUDES_QCOM_COMMON),true)
    include $(COMMON_PATH)/hardware/qcom/utils.mk
    include device/qcom/common/common.mk
endif

# QTI VNDK Framework Detect
PRODUCT_PACKAGES += \
    libvndfwk_detect_jni.qti \
    libqti_vndfwk_detect \
    libvndfwk_detect_jni.qti.vendor \
    libqti_vndfwk_detect.vendor
