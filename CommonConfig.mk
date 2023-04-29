# Copyright 2014 The Android Open Source Project
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

# Fixes
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true

# Architecture
TARGET_ARCH := arm64
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic

TARGET_2ND_ARCH := arm
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic

TARGET_SUPPORTS_64_BIT_APPS := true

# AVB
ifeq ($(TARGET_HAS_VBMETA_SYSTEM),true)
  BOARD_AVB_VBMETA_SYSTEM := system
  BOARD_AVB_VBMETA_SYSTEM_KEY_PATH ?= external/avb/test/data/testkey_rsa2048.pem
  BOARD_AVB_VBMETA_SYSTEM_ALGORITHM ?= SHA256_RSA2048
  BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
  BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 1
endif

# Boot Image
BOARD_BOOTIMAGE_PARTITION_SIZE ?= 100663296
BOARD_INCLUDE_DTB_IN_BOOTIMG ?= true
BOARD_KERNEL_PAGESIZE ?= 4096

## Header
BOARD_BOOT_HEADER_VERSION ?= 2
BOARD_DTB_OFFSET ?= 0x01f00000
BOARD_KERNEL_BASE ?= 0x00000000
BOARD_RAMDISK_OFFSET ?= 0x01000000
BOARD_MKBOOTIMG_ARGS += \
    --ramdisk_offset $(BOARD_RAMDISK_OFFSET) --header_version $(BOARD_BOOT_HEADER_VERSION) --dtb_offset $(BOARD_DTB_OFFSET)

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME ?= $(PRODUCT_DEVICE)

# Dexpreopt
WITH_DEXPREOPT := true

# Filesystem
BOARD_ROOT_EXTRA_SYMLINKS += /mnt/vendor/persist:/persist
BOARD_USES_METADATA_PARTITION := true
TARGET_FS_CONFIG_GEN += $(COMMON_PATH)/mot_aids.fs

## Utilities
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# Kernel
BOARD_FLASH_BLOCK_SIZE ?= 131072
BOARD_KERNEL_IMAGE_NAME ?= Image.gz-dtb
ifneq ($(BOARD_USES_DTBO),false)
  BOARD_DTBOIMG_PARTITION_SIZE ?= 25165824
  BOARD_KERNEL_SEPARATED_DTBO := true
  ifneq ($(TARGET_PREBUILT_KERNEL),)
    BOARD_PREBUILT_DTBIMAGE_DIR ?= device/motorola/$(PRODUCT_DEVICE)-kernel/dtbs
    BOARD_PREBUILT_DTBOIMAGE ?= device/motorola/$(PRODUCT_DEVICE)-kernel/dtbo.img
  endif
endif

## Common cmdline parameters
BOARD_KERNEL_CMDLINE += \
    androidboot.console=ttyMSM0 androidboot.hardware=qcom \
    androidboot.memcg=1 group.memory=nokmem,nosocket \
    loop.max_part=7 service_locator.enable=1 swiotlb=0 \
    cgroup_disable=pressure
ifneq ($(BOARD_USE_ENFORCING_SELINUX),true)
  BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive
endif

### Kernel Modules
ifneq ($(TARGET_PREBUILT_KERNEL),)
  BOARD_VENDOR_KERNEL_MODULES ?= \
      $(wildcard device/motorola/$(PRODUCT_DEVICE)-kernel/modules/*.ko)
endif

# Memory
MALLOC_SVELTE := true

# QCOM
ifeq ($(PRODUCT_USES_QCOM_HARDWARE),true)
  include $(COMMON_PATH)/hardware/qcom/board.mk
endif
TARGET_USES_HARDWARE_QCOM_GPS := false

# Recovery
BOARD_INCLUDE_RECOVERY_DTBO := true
TARGET_NO_RECOVERY ?= false
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888

# RIL
ENABLE_VENDOR_RIL_SERVICE := true

# Security patch level
## Used by newer keymaster binaries
VENDOR_SECURITY_PATCH=$(PLATFORM_SECURITY_PATCH)

# SELinux
include device/sony/sepolicy/sepolicy.mk
BOARD_USE_ENFORCING_SELINUX ?= true
BOARD_VENDOR_SEPOLICY_DIRS += $(COMMON_PATH)/sepolicy/vendor

# USB
SOONG_CONFIG_NAMESPACES += MOTO_COMMON_USB MOTO_COMMON_POWER
SOONG_CONFIG_MOTO_COMMON_USB := USB_CONTROLLER_NAME
SOONG_CONFIG_MOTO_COMMON_USB_USB_CONTROLLER_NAME ?= 4e00000
SOONG_CONFIG_MOTO_COMMON_POWER := FB_IDLE_PATH
SOONG_CONFIG_MOTO_COMMON_POWER_FB_IDLE_PATH ?= /sys/devices/platform/soc/5e00000.qcom,mdss_mdp/idle_state

# VINTF
DEVICE_MANIFEST_FILE += $(COMMON_PATH)/vintf/manifest.xml
ifneq ($(TARGET_USES_FINGERPRINT_V2_1),false)
  DEVICE_MANIFEST_FILE += $(COMMON_PATH)/vintf/android.hardware.biometrics.fingerprint_v2.1.xml
endif
## Framework compatibility matrix: What the device(=vendor) expects of the framework(=system)
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE += $(COMMON_PATH)/vintf/framework_compatibility_matrix.xml
DEVICE_MATRIX_FILE += $(COMMON_PATH)/vintf/compatibility_matrix.xml

# Wi-Fi Concurrent STA/AP / Init
WIFI_HIDL_FEATURE_DUAL_INTERFACE := true
WIFI_HIDL_UNIFIED_SUPPLICANT_SERVICE_RC_ENTRY := true
