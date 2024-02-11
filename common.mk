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
AB_OTA_POSTINSTALL_CONFIG ?= \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    POSTINSTALL_OPTIONAL_system=true

# Arch
TARGET_ARCH := arm64

# Audio Configuration
PRODUCT_COPY_FILES += \
    frameworks/av/services/audiopolicy/config/a2dp_in_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/a2dp_in_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/bluetooth_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/bluetooth_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/r_submix_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/r_submix_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/usb_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/usb_audio_policy_configuration.xml

# Bluetooth
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := build/make/target/board/mainline_arm64/bluetooth

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

## Create libhidl symlink
PRODUCT_PACKAGES += \
    libhidl_symlink

## Create protobuf symlinks
PRODUCT_PACKAGES += \
    protobuf_symlinks

# FSTab Handling
## Define suffix for fstab
ifeq ($(PRODUCT_USES_QCOM_HARDWARE),true) # QCOM uses qcom
  FSTAB_SUFFIX := qcom
else ifeq ($(PRODUCT_USES_MTK_HARDWARE),true) # MTK uses board platform
  FSTAB_SUFFIX := $(TARGET_BOARD_PLATFORM)
endif

## Select fstab path based on vendor_boot and recovery's existence
fstab_path := $(PLATFORM_COMMON_PATH)/rootdir/$(call select-fstab)
ifeq ($(call has-partition,vendor_boot),false)
  ifeq ($(AB_OTA_UPDATER),true)
    ifeq ($(call has-partition,recovery),true)
      PRODUCT_COPY_FILES += \
          $(fstab_path):$(TARGET_COPY_OUT_RAMDISK)/fstab.$(FSTAB_SUFFIX)
    else
      PRODUCT_COPY_FILES += \
          $(fstab_path):$(TARGET_COPY_OUT_RECOVERY)/root/first_stage_ramdisk/fstab.$(FSTAB_SUFFIX)
    endif
  endif
else
  PRODUCT_COPY_FILES += \
      $(fstab_path):$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.$(FSTAB_SUFFIX)
endif
## Always copy fstab to vendor
PRODUCT_COPY_FILES += \
    $(fstab_path):$(TARGET_COPY_OUT_VENDOR)/etc/fstab.$(FSTAB_SUFFIX)

## Sanity check fstab to prevent boot issues
## First check the expected partition type
ifeq ($(call device-has-characteristic,erofs),true)
  PARTITION_TYPE := erofs
else
  PARTITION_TYPE := ext4
endif
## Then check the fstab actually exists...
ifeq (,$(wildcard $(fstab_path)))
  $(error $(fstab_path) does not exist!)
endif
## Check the contents for just /vendor,
## its unlikely fstab will just have /vendor
## as the expected partition type not the others
fstab_contents := $(strip $(shell cat $(fstab_path)))
ifeq (,$(findstring /vendor $(PARTITION_TYPE),$(fstab_contents)))
  $(error $(PARTITION_TYPE) not defined in fstab!)
endif
## Now that we know the partition type, let's add
## it to AB_OTA_POSTINSTALL_CONFIG
AB_OTA_POSTINSTALL_CONFIG += \
    FILESYSTEM_TYPE_system=$(PARTITION_TYPE)

# Media codecs configuration
PRODUCT_COPY_FILES += \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_telephony.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_telephony.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_video.xml

# Mediatek
ifeq ($(PRODUCT_USES_MTK_HARDWARE),true)
  include $(COMMON_PATH)/hardware/mediatek/product.mk
endif

# NFC
ifneq (,$(filter $(TARGET_USES_SN1XX_NFC) $(TARGET_USES_PN5XX_PN8X_NFC) $(TARGET_USES_ST_NFC) $(TARGET_USES_SEC_NFC), true))
  DEVICE_CHARACTERISTICS += nfc
endif

# QCOM
ifeq ($(PRODUCT_USES_QCOM_HARDWARE),true)
  include $(COMMON_PATH)/hardware/qcom/product.mk
endif

# Recovery
TARGET_RECOVERY_FSTAB := $(fstab_path)

# Rootdir
$(call copy-files-recursive,$(COMMON_PATH)/rootdir/vendor,$(TARGET_COPY_OUT_VENDOR))
$(call copy-files-recursive,$(DEVICE_PATH)/vendor,$(TARGET_COPY_OUT_VENDOR))
$(call copy-files-recursive,$(PLATFORM_COMMON_PATH)/rootdir/vendor,$(TARGET_COPY_OUT_VENDOR))

# SKUs
## With NFC
$(call add-device-sku,n,nfc)
## Default Without NFC
$(call add-device-sku-inner,d)

# Soong
PRODUCT_SOONG_NAMESPACES += \
    $(COMMON_PATH) \
    $(PLATFORM_COMMON_PATH)

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
