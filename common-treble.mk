# RenderScript HAL
PRODUCT_PACKAGES += \
    android.hardware.renderscript@1.0-impl

# Composer
# Everything prior to kernel 4.19 uses the sm8150 display HALs
ifeq ($(filter 4.14, $(KERNEL_VERSION)),)
PRODUCT_PACKAGES += \
    vendor.qti.hardware.display.composer-service
else
PRODUCT_PACKAGES += \
    android.hardware.graphics.composer@2.4-service
endif

# Linked by Adreno/EGL blobs for fallback if 3.0 doesn't exist
PRODUCT_PACKAGES += \
    vendor.qti.hardware.display.allocator@3.0.vendor \
    vendor.qti.hardware.display.mapper@2.0.vendor

# Linked by Perf HAL
PRODUCT_PACKAGES += \
    vendor.display.config@1.0.vendor

# Graphics allocator/mapper
PRODUCT_PACKAGES += \
    android.hardware.graphics.mapper@3.0-impl-qti-display \
    android.hardware.graphics.mapper@4.0-impl-qti-display

# TODO Verify Gralloc4
PRODUCT_PACKAGES += \
    vendor.qti.hardware.display.allocator-service

# Memtrack
PRODUCT_PACKAGES += \
    android.hardware.memtrack@1.0-impl \
    android.hardware.memtrack@1.0-service \
    memtrack.default

# Configstore
ifeq ($(filter 4.14, $(KERNEL_VERSION)),)
PRODUCT_PACKAGES += \
    disable_configstore
else
PRODUCT_PACKAGES += \
    android.hardware.configstore@1.1-service
DEVICE_MANIFEST_FILE += $(COMMON_PATH)/vintf/android.hardware.configstore_v1.1.xml
endif

# RIL
# Interface library needed by vendor blobs:
PRODUCT_PACKAGES += \
    android.hardware.radio@1.2.vendor \
    android.hardware.radio@1.3.vendor \
    android.hardware.radio@1.4.vendor \
    android.hardware.radio@1.5.vendor \
    android.hardware.radio.config@1.0.vendor \
    android.hardware.radio.config@1.1.vendor \
    android.hardware.radio.config@1.2.vendor \
    android.hardware.radio.deprecated@1.0.vendor \
    android.hardware.secure_element@1.2.vendor

# netmgrd
PRODUCT_PACKAGES += \
    android.system.net.netd@1.1.vendor

# Health
PRODUCT_PACKAGES += \
    android.hardware.health@2.1-impl \
    android.hardware.health@2.1-service

# Audio
PRODUCT_PACKAGES += \
    android.hardware.audio@6.0-impl:32 \
    android.hardware.audio.service \
    android.hardware.audio.effect@6.0-impl:32 \
    android.hardware.bluetooth@1.0.vendor \
    android.hardware.bluetooth.audio@2.0-impl \
    android.hardware.soundtrigger@2.1.vendor \
    android.hardware.soundtrigger@2.2.vendor \
    android.hardware.soundtrigger@2.3.vendor \
    android.hardware.soundtrigger@2.3-impl

# Camera
PRODUCT_PACKAGES += \
    android.hardware.camera.provider@2.5 \
    android.frameworks.displayservice@1.0.vendor \
    android.frameworks.sensorservice@1.0.vendor \
    vendor.qti.hardware.camera.postproc@1.0.vendor
ifeq ($(TARGET_USES_64BIT_CAMERA),true)
PRODUCT_PACKAGES += \
    android.hardware.camera.provider@2.4-impl:64 \
    android.hardware.camera.provider@2.4-service_64
else
PRODUCT_PACKAGES += \
    android.hardware.camera.provider@2.4-impl:32 \
    android.hardware.camera.provider@2.4-service
endif

# GNSS
PRODUCT_PACKAGES += \
    android.hardware.gnss@2.1-impl-qti \
    android.hardware.gnss@2.1-service-qti

# QTI Haptics Vibrator
PRODUCT_PACKAGES += \
    vendor.qti.hardware.vibrator.service

# Fingerprint
PRODUCT_PACKAGES += \
    android.hardware.biometrics.fingerprint@2.1.vendor

# DRM
PRODUCT_PACKAGES += \
    android.hardware.drm@1.0-impl \
    android.hardware.drm@1.0-service-lazy \
    android.hardware.drm@1.3-service-lazy.clearkey

# Thermal HAL
PRODUCT_PACKAGES += \
    android.hardware.thermal@2.0-service.qti

# Power HAL
$(call inherit-product, vendor/qcom/opensource/power/power-vendor-product.mk)

# Only define bootctrl HAL availability on AB platforms:
ifeq ($(AB_OTA_UPDATER),true)
PRODUCT_PACKAGES += \
    android.hardware.boot@1.1-impl-qti \
    android.hardware.boot@1.1-impl-qti.recovery \
    android.hardware.boot@1.1-service
endif

# Proprietary Blobs
QCOM_COMMON_PATH := device/qcom/common
# System
include $(QCOM_COMMON_PATH)/system/audio/qti-audio.mk
include $(QCOM_COMMON_PATH)/system/av/qti-av.mk
include $(QCOM_COMMON_PATH)/system/display/qti-display.mk
include $(QCOM_COMMON_PATH)/system/gps/qti-gps.mk
include $(QCOM_COMMON_PATH)/system/overlay/qti-overlay.mk
include $(QCOM_COMMON_PATH)/system/perf/qti-perf.mk
# Vendor
include $(QCOM_COMMON_PATH)/vendor/adreno/qti-adreno.mk
include $(QCOM_COMMON_PATH)/vendor/dsprpcd/qti-dsprpcd.mk
include $(QCOM_COMMON_PATH)/vendor/keymaster/qti-keymaster.mk
ifeq ($(KERNEL_VERSION),5.4)
include $(QCOM_COMMON_PATH)/vendor/media/qti-media.mk
else
include $(QCOM_COMMON_PATH)/vendor/media-legacy/qti-media-legacy.mk
endif
include $(QCOM_COMMON_PATH)/vendor/perf/qti-perf.mk
ifneq ($(KERNEL_VERSION),5.4)
include $(QCOM_COMMON_PATH)/vendor/qseecomd-legacy/qti-qseecomd-legacy.mk
else
include $(QCOM_COMMON_PATH)/vendor/qseecomd/qti-qseecomd.mk
endif
include $(QCOM_COMMON_PATH)/vendor/usb/qti-usb.mk
include $(QCOM_COMMON_PATH)/vendor/wlan/qti-wlan.mk

PRODUCT_SOONG_NAMESPACES += \
    vendor/qcom/common/vendor/dsprpcd
