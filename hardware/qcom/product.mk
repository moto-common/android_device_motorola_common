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

# Power
TARGET_PROVIDES_POWERHAL := true

# QCOM Common Product Hook
ifneq ($(ROM_INCLUDES_QCOM_COMMON),true)
  include $(COMMON_PATH)/hardware/qcom/utils.mk
  include device/qcom/common/common.mk
endif

# QTI VNDK Framework Detect
PRODUCT_ODM_PROPERTIES += \
    ro.vendor.qti.va_odm.support=1

PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.qti.va_aosp.support=1

PRODUCT_PACKAGES += \
    libvndfwk_detect_jni.qti \
    libqti_vndfwk_detect \
    libvndfwk_detect_jni.qti.vendor \
    libqti_vndfwk_detect.vendor

# Telephony: IMS framework
PRODUCT_COPY_FILES += \
    $(COMMON_PATH)/hardware/qcom/permissions/privapp-permissions-ims.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/permissions/privapp-permissions-ims.xml
