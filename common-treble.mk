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
    android.hardware.audio.common@7.0.vendor \
    android.hardware.audio.effect@7.0.vendor \
    android.hardware.audio.common@7.0-util.vendor \
    android.hardware.audio@6.0-impl:32 \
    android.hardware.audio@7.0.vendor \
    android.hardware.audio.service \
    android.hardware.audio.effect@6.0-impl:32 \
    android.hardware.bluetooth@1.0.vendor \
    android.hardware.bluetooth@1.1.vendor \
    android.hardware.bluetooth.audio-impl \
    android.hardware.soundtrigger@2.1.vendor \
    android.hardware.soundtrigger@2.2.vendor \
    android.hardware.soundtrigger@2.3.vendor \
    android.hardware.soundtrigger@2.3-impl

# Camera
PRODUCT_PACKAGES += \
    android.hardware.camera.device@3.5.vendor \
    android.hardware.camera.device@3.6.vendor \
    android.hardware.camera.provider@2.5.vendor \
    android.hardware.camera.provider@2.6.vendor \
    android.frameworks.displayservice@1.0.vendor \
    android.frameworks.sensorservice@1.0.vendor

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
# Power
PRODUCT_PACKAGES += \
    android.hardware.power@1.0.vendor \
    android.hardware.power@1.1.vendor \
    android.hardware.power@1.2.vendor

PRODUCT_PACKAGES += \
    android.hardware.power-service.moto-common-libperfmgr

# QTI Haptics Vibrator
## Used on MTK and QCOM for now
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
ifneq ($(PRODUCT_USES_MTK_HARDWARE),true)
  PRODUCT_PACKAGES += \
      android.hardware.sensors@2.0-service.multihal
endif

# Thermal HAL
PRODUCT_PACKAGES += \
    android.hardware.thermal@1.0.vendor \
    android.hardware.thermal@2.0.vendor

# USB HAL
PRODUCT_PACKAGES += \
    android.hardware.usb@1.3-service.moto-common

# WiFi
PRODUCT_PACKAGES += \
    android.hardware.wifi.hostapd@1.0.vendor \
    android.hardware.wifi@1.0-service-lazy \
    wpa_supplicant \
    hostapd
