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

# Common path
COMMON_PATH := device/motorola/common

# A/B OTA dexopt update_engine hookup
ifeq ($(AB_OTA_UPDATER),true)
  AB_OTA_POSTINSTALL_CONFIG += \
      RUN_POSTINSTALL_system=true \
      POSTINSTALL_PATH_system=system/bin/otapreopt_script \
      FILESYSTEM_TYPE_system=ext4 \
      POSTINSTALL_OPTIONAL_system=true
endif

# Additional native libraries
# See https://source.android.com/devices/tech/config/namespaces_libraries
PRODUCT_COPY_FILES += \
    $(COMMON_PATH)/rootdir/vendor/etc/public.libraries.txt:$(TARGET_COPY_OUT_VENDOR)/etc/public.libraries.txt

# Arch
TARGET_ARCH := arm64

# Audio Configuration
PRODUCT_COPY_FILES += \
    $(COMMON_PATH)/rootdir/vendor/etc/audio_effects.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_effects.xml \
    frameworks/av/services/audiopolicy/config/a2dp_in_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/a2dp_in_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/bluetooth_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/bluetooth_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/r_submix_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/r_submix_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/usb_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/usb_audio_policy_configuration.xml

# Bluetooth
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(COMMON_PATH)/bluetooth

PRODUCT_COPY_FILES += \
    $(COMMON_PATH)/rootdir/vendor/etc/sysconfig/component-overrides.xml:$(TARGET_COPY_OUT_VENDOR)/etc/sysconfig/component-overrides.xml

# Build scripts
MOTOROLA_CLEAR_VARS := $(COMMON_PATH)/motorola_clear_vars.mk
MOTOROLA_BUILD_SYMLINKS := $(COMMON_PATH)/motorola_build_symlinks.mk

# Camera
TARGET_USES_64BIT_CAMERA ?= true

# Dexpreopt
PRODUCT_DEXPREOPT_SPEED_APPS += SystemUI

# Dynamic Partitions
ifeq ($(TARGET_USES_DYNAMIC_PARTITIONS),true)
  PRODUCT_USE_DYNAMIC_PARTITIONS := true
endif

# Filesystem: Create tftp symlinks
PRODUCT_PACKAGES += \
    tftp_symlinks

## Create firmware mount point folders in /vendor:
PRODUCT_PACKAGES += \
    firmware_folders

# Kernel
PRODUCT_VENDOR_KERNEL_HEADERS := $(PLATFORM_COMMON_PATH)-kernel/kernel-headers

# Media codecs configuration
PRODUCT_COPY_FILES += \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_telephony.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_telephony.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_video.xml

# NFC
ifneq (,$(filter $(TARGET_USES_SN1XX_NFC) $(TARGET_USES_PN5XX_PN8X_NFC), true))
  TARGET_SUPPORTS_NFC := true
endif

# QCOM
ifeq ($(PRODUCT_USES_QCOM_HARDWARE),true)
  include $(COMMON_PATH)/hardware/qcom/product.mk
endif

# QMI
PRODUCT_COPY_FILES += \
    $(COMMON_PATH)/rootdir/vendor/etc/data/dsi_config.xml:$(TARGET_COPY_OUT_VENDOR)/etc/data/dsi_config.xml \
    $(COMMON_PATH)/rootdir/vendor/etc/data/netmgr_config.xml:$(TARGET_COPY_OUT_VENDOR)/etc/data/netmgr_config.xml

# QSEECOM TZ Storage
PRODUCT_COPY_FILES += \
    $(COMMON_PATH)/rootdir/vendor/etc/gpfspath_oem_config.xml:$(TARGET_COPY_OUT_VENDOR)/etc/gpfspath_oem_config.xml

## Sec Configuration
PRODUCT_COPY_FILES += \
    $(COMMON_PATH)/rootdir/vendor/etc/sec_config:$(TARGET_COPY_OUT_VENDOR)/etc/sec_config

# Seccomp policy
PRODUCT_COPY_FILES += \
    $(COMMON_PATH)/rootdir/vendor/etc/seccomp_policy/imsrtp.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/imsrtp.policy

# Soong
PRODUCT_SOONG_NAMESPACES += \
    $(COMMON_PATH) \
    $(PLATFORM_COMMON_PATH) \
    vendor/qcom/opensource/audio/$(qcom_platform) \
    vendor/qcom/opensource/data-ipa-cfg-mgr-legacy-um \
    vendor/qcom/opensource/dataservices \
    vendor/qcom/opensource/display/$(qcom_platform) \
    vendor/qcom/opensource/display-commonsys-intf

## Enable pixel soong namespace for Pixel USB and Power HAL
PRODUCT_SOONG_NAMESPACES += \
    hardware/google/interfaces \
    hardware/google/pixel

# APEX
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

$(call inherit-product, device/motorola/common/common-init.mk)
$(call inherit-product, device/motorola/common/common-packages.mk)
$(call inherit-product, device/motorola/common/common-perm.mk)
$(call inherit-product, device/motorola/common/common-prop.mk)
$(call inherit-product, device/motorola/common/common-treble.mk)
$(call inherit-product, vendor/motorola/common/common-vendor.mk)
