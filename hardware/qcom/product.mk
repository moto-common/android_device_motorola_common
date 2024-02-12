# QCOM Platform selector
ifeq ($(TARGET_KERNEL_VERSION), 5.10)
  qcom_platform := sm8450
else ifeq ($(TARGET_KERNEL_VERSION), 5.4)
  qcom_platform := sm8350
else ifeq ($(TARGET_KERNEL_VERSION), 4.19)
  qcom_platform := sm8250
else
  qcom_platform := sm8150
endif

# A/B OTA Updater
ifeq ($(AB_OTA_UPDATER),true)
  PRODUCT_PACKAGES += \
      android.hardware.boot@1.2-impl-qti \
      android.hardware.boot@1.2-impl-qti.recovery \
      android.hardware.boot@1.2-service \
      bootctrl.$(TARGET_BOARD_PLATFORM) \
      bootctrl.$(TARGET_BOARD_PLATFORM).recovery
endif

# Audio
$(call inherit-product-if-exists, vendor/qcom/opensource/audio/$(qcom_platform)/configs/$(TARGET_BOARD_PLATFORM)/$(TARGET_BOARD_PLATFORM).mk)

# Bluetooth
PRODUCT_PACKAGES += \
    com.dsi.ant@1.0.vendor \
    com.qualcomm.qti.bluetooth_audio@1.0.vendor \
    vendor.qti.hardware.btconfigstore@1.0.vendor \
    vendor.qti.hardware.btconfigstore@2.0.vendor

# Camera
PRODUCT_PACKAGES += \
    vendor.qti.hardware.camera.postproc@1.0.vendor

ifneq ($(call is-kernel-greater-than-or-equal-to,5.10),true)
  ifeq ($(TARGET_USES_64BIT_CAMERA),true)
    PRODUCT_PACKAGES += \
        android.hardware.camera.provider@2.4-impl:64 \
        android.hardware.camera.provider@2.4-service_64
  else
    PRODUCT_PACKAGES += \
        android.hardware.camera.provider@2.4-impl:32 \
        android.hardware.camera.provider@2.4-service
  endif
  TARGET_USES_CAMERA_V2_4 := true
endif

# Components
TARGET_COMMON_QTI_COMPONENTS := \
    adreno \
    audio \
    av \
    charging \
    display \
    dsprpcd \
    init \
    gps \
    keymaster \
    media \
    neuralnetworks \
    overlay \
    qseecomd \
    vibrator \
    wlan
## Filter out unwanted components
TARGET_COMMON_QTI_COMPONENTS := $(filter-out $(TARGET_UNWANTED_QTI_COMPONENTS),$(TARGET_COMMON_QTI_COMPONENTS))

# Dataservices
$(call soong_config_set,rmnetctl,old_rmnet_data,true)

# Display
$(call inherit-product-if-exists, vendor/qcom/opensource/display/$(qcom_platform)/config/display-product.mk)
$(call inherit-product-if-exists, vendor/qcom/opensource/display-commonsys-intf/config/display-interfaces-product.mk)

# FM
ifeq ($(call device-has-characteristic,fm),true)
  PRODUCT_PACKAGES += \
      FM2 \
      libfm-hci \
      libqcomfm_jni \
      fm_helium \
      qcom.fmradio
endif

## Used for bluetooth
PRODUCT_PACKAGES += \
    vendor.qti.hardware.fm@1.0 \
    vendor.qti.hardware.fm@1.0.vendor

# GPS
TARGET_USES_$(call upper,$(qcom_platform))_GPS := true
ifeq ($(call is-kernel-less-than-or-equal-to,5.4),true)
  PRODUCT_SOONG_NAMESPACES += vendor/qcom/opensource/gps/legacy
  $(call inherit-product-if-exists, vendor/qcom/opensource/gps/legacy/gps_vendor_product.mk)
  TARGET_USES_OLD_GPS := true
else
  PRODUCT_SOONG_NAMESPACES += vendor/qcom/opensource/gps/$(qcom_platform)
  $(call inherit-product-if-exists, vendor/qcom/opensource/gps/$(qcom_platform)/gps_vendor_product.mk)
endif

# Kernel
TARGET_USES_KERNEL_PLATFORM := false

# Keymaster
PRODUCT_PACKAGES += \
    libkeymaster_messages.vendor

# Linked by Adreno/EGL blobs for fallback if 3.0 doesn't exist
PRODUCT_PACKAGES += \
    vendor.qti.hardware.display.allocator@3.0.vendor \
    vendor.qti.hardware.display.mapper@2.0.vendor

# Media
$(call inherit-product-if-exists, vendor/qcom/opensource/media/$(qcom_platform)/product.mk)

# Power
TARGET_PROVIDES_POWERHAL := true

# QCOM Common Product Hook
ifneq ($(ROM_INCLUDES_QCOM_COMMON),true)
  include $(COMMON_PATH)/hardware/qcom/utils.mk
  include device/qcom/common/common.mk
endif

# QCOM Data
PRODUCT_PACKAGES += \
    librmnetctl

# QTI VNDK Framework Detect
PRODUCT_ODM_PROPERTIES += \
    ro.vendor.qti.va_odm.support=1

PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.qti.va_aosp.support=1

PRODUCT_PACKAGES += \
    libvndfwk_detect_jni.qti \
    libqti_vndfwk_detect \
    libvndfwk_detect_jni.qti.vendor \
    libqti_vndfwk_detect.vendor \
    libqti_vndfwk_detect_vendor

# RIL
PRODUCT_PACKAGES += \
    libqsap_sdk \
    qti-telephony-hidl-wrapper \
    qti-telephony-hidl-wrapper-prd \
    qti_telephony_hidl_wrapper.xml \
    qti_telephony_hidl_wrapper_prd.xml \
    qti-telephony-utils \
    qti_telephony_utils.xml

# Soong
PRODUCT_SOONG_NAMESPACES += \
    vendor/qcom/opensource/audio/$(qcom_platform) \
    vendor/qcom/opensource/data-ipa-cfg-mgr-legacy-um \
    vendor/qcom/opensource/dataservices \
    vendor/qcom/opensource/display/$(qcom_platform) \
    vendor/qcom/opensource/display-commonsys-intf

# Telephony: IMS framework
PRODUCT_COPY_FILES += \
    $(COMMON_PATH)/hardware/qcom/permissions/privapp-permissions-ims.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/permissions/privapp-permissions-ims.xml

# Thermal
PRODUCT_SOONG_NAMESPACES += \
    vendor/qcom/opensource/thermal

PRODUCT_PACKAGES += \
    android.hardware.thermal@2.0-service.qti

# WLAN
PRODUCT_COPY_FILES += \
    $(COMMON_PATH)/hardware/qcom/bin/cnss-daemon_moto:$(TARGET_COPY_OUT_VENDOR)/bin/cnss-daemon_moto

# Vendor
$(call inherit-product, vendor/motorola/common/hardware/qcom/qcom-vendor.mk)

# VINTF
ifeq ($(call is-kernel-greater-than-or-equal-to,5.10),true)
  TARGET_USES_TETHER_V1_1 := true
endif
