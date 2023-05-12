# Copyright (C) 2014 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Audio
PRODUCT_PACKAGES += \
    android.hardware.audio@6.0-impl:32 \
    android.hardware.audio.service \
    android.hardware.audio.effect@6.0-impl:32 \
    android.hardware.bluetooth@1.0.vendor \
    android.hardware.bluetooth.audio-impl \
    android.hardware.soundtrigger@2.1.vendor \
    android.hardware.soundtrigger@2.2.vendor \
    android.hardware.soundtrigger@2.3.vendor \
    android.hardware.soundtrigger@2.3-impl \
    com.dsi.ant@1.0.vendor \
    com.qualcomm.qti.bluetooth_audio@1.0.vendor \
    vendor.qti.hardware.btconfigstore@1.0.vendor \
    vendor.qti.hardware.btconfigstore@2.0.vendor

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

# Configstore
PRODUCT_PACKAGES += \
    disable_configstore

# DRM
PRODUCT_PACKAGES += \
    android.hardware.drm@1.0.vendor \
    android.hardware.drm@1.1.vendor \
    android.hardware.drm@1.2.vendor \
    android.hardware.drm@1.3.vendor \
    android.hardware.drm-service-lazy.clearkey

# Fingerprint
PRODUCT_PACKAGES += \
    android.hardware.biometrics.fingerprint@2.1.vendor \
    com.motorola.hardware.biometric.fingerprint@1.0.vendor

# FM
PRODUCT_PACKAGES += \
    vendor.qti.hardware.fm@1.0 \
    vendor.qti.hardware.fm@1.0.vendor

# GNSS
PRODUCT_PACKAGES += \
    android.hardware.gnss.measurement_corrections@1.0.vendor \
    android.hardware.gnss.measurement_corrections@1.1.vendor \
    android.hardware.gnss.visibility_control@1.0.vendor \
    android.hardware.gnss@1.0.vendor \
    android.hardware.gnss@1.1.vendor \
    android.hardware.gnss@2.0.vendor \
    android.hardware.gnss@2.1.vendor

# Health
PRODUCT_PACKAGES += \
    android.hardware.health@2.1-impl \
    android.hardware.health@2.1-service

# Lights HAL
PRODUCT_PACKAGES += \
    android.hardware.lights-service.moto

# Linked by Adreno/EGL blobs for fallback if 3.0 doesn't exist
PRODUCT_PACKAGES += \
    vendor.qti.hardware.display.allocator@3.0.vendor \
    vendor.qti.hardware.display.mapper@2.0.vendor

# Netmgrd
PRODUCT_PACKAGES += \
    android.system.net.netd@1.1.vendor

# NFC
ifeq ($(TARGET_SUPPORTS_NFC),true)
  PRODUCT_PACKAGES += \
      android.hardware.nfc@1.2.vendor \
      android.hardware.secure_element@1.2.vendor
endif

## Specific Chips
ifeq ($(TARGET_USES_PN5XX_PN8X_NFC),true)
  PRODUCT_PACKAGES += \
      android.hardware.nfc@1.2-service
endif
ifeq ($(TARGET_USES_SEC_NFC),true)
  PRODUCT_PACKAGES += \
      android.hardware.nfc@1.2-service.samsung \
      nfc_nci_samsung
endif
ifeq ($(TARGET_USES_SN1XX_NFC),true)
  PRODUCT_PACKAGES += \
      android.hardware.nfc_snxxx@1.2-service
endif
ifeq ($(TARGET_USES_ST_NFC),true)
  PRODUCT_PACKAGES += \
      android.hardware.nfc@1.2-service.st \
      nfc_nci.st21nfc.default
endif

# Only define bootctrl HAL availability on AB platforms:
ifeq ($(AB_OTA_UPDATER),true)
  PRODUCT_PACKAGES += \
      android.hardware.boot@1.1-impl-qti \
      android.hardware.boot@1.1-impl-qti.recovery \
      android.hardware.boot@1.1-service
endif

# Power
PRODUCT_PACKAGES += \
    android.hardware.power@1.0.vendor \
    android.hardware.power@1.1.vendor \
    android.hardware.power@1.2.vendor

ifeq ($(PRODUCT_USES_PIXEL_POWER_HAL),true)
  PRODUCT_PACKAGES += \
      android.hardware.power-service.moto-common-libperfmgr
else
  $(call inherit-product, vendor/qcom/opensource/power/power-vendor-product.mk)
endif

# QTI Haptics Vibrator
PRODUCT_PACKAGES += \
    vendor.qti.hardware.vibrator.service

# RIL
## Interface library needed by vendor blobs:
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

# Sensors
PRODUCT_PACKAGES += \
    android.hardware.sensors@2.0-service.multihal

# Thermal HAL
PRODUCT_SOONG_NAMESPACES += \
    vendor/qcom/opensource/thermal

PRODUCT_PACKAGES += \
    android.hardware.thermal@2.0-service.qti

# USB HAL
PRODUCT_PACKAGES += \
    android.hardware.usb@1.3-service.moto-common

# WiFi
PRODUCT_PACKAGES += \
    android.hardware.wifi.hostapd@1.0.vendor
