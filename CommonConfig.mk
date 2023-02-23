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

# Fixes
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true

# Common path
COMMON_PATH := device/motorola/common

# AOSP
TARGET_BUILDS_AOSP := true

# Recovery
TARGET_NO_RECOVERY ?= false

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME ?= $(PRODUCT_DEVICE)

# Kernel
BOARD_KERNEL_IMAGE_NAME := Image.gz-dtb
BOARD_FLASH_BLOCK_SIZE ?= 131072
BOARD_PREBUILT_DTBIMAGE_DIR ?= device/motorola/$(PRODUCT_DEVICE)-kernel/dtbs
ifneq ($(BOARD_USES_DTBO),false)
BOARD_PREBUILT_DTBOIMAGE ?= device/motorola/$(PRODUCT_DEVICE)-kernel/dtbo.img
endif

# Kernel Modules
BOARD_VENDOR_KERNEL_MODULES ?= \
    $(wildcard device/motorola/$(PRODUCT_DEVICE)-kernel/modules/*.ko)

# common cmdline parameters
ifneq ($(BOARD_USE_ENFORCING_SELINUX),true)
BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive
endif
BOARD_KERNEL_CMDLINE += androidboot.console=ttyMSM0
BOARD_KERNEL_CMDLINE += androidboot.memcg=1
BOARD_KERNEL_CMDLINE += androidboot.hardware=qcom
BOARD_KERNEL_CMDLINE += loop.max_part=7
BOARD_KERNEL_CMDLINE += service_locator.enable=1
BOARD_KERNEL_CMDLINE += swiotlb=0
BOARD_KERNEL_CMDLINE += cgroup.memory=nokmem,nosocket

BOARD_MKBOOTIMG_ARGS := --ramdisk_offset $(BOARD_RAMDISK_OFFSET) --header_version $(BOARD_BOOT_HEADER_VERSION)

# CPU ARCH
TARGET_ARCH := arm64
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic

TARGET_2ND_ARCH := arm
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic

TARGET_SUPPORTS_64_BIT_APPS := true

# Use mke2fs to create ext4/f2fs images
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

BOARD_ROOT_EXTRA_SYMLINKS += /mnt/vendor/persist:/persist

# Filesystem
TARGET_FS_CONFIG_GEN += $(COMMON_PATH)/mot_aids.fs

# Media
TARGET_USES_ION := true

# Charger
BOARD_CHARGER_DISABLE_INIT_BLANK := true
BOARD_CHARGER_ENABLE_SUSPEND := true

# Wi-Fi Concurrent STA/AP
WIFI_HIDL_FEATURE_DUAL_INTERFACE := true
# Wi-Fi Init
WIFI_HIDL_UNIFIED_SUPPLICANT_SERVICE_RC_ENTRY := true

# Enable dex-preoptimization to speed up first boot sequence
WITH_DEXPREOPT := true

# SELinux
include device/sony/sepolicy/sepolicy.mk
BOARD_VENDOR_SEPOLICY_DIRS += $(COMMON_PATH)/sepolicy/vendor

# Device manifest: What HALs the device provides
DEVICE_MANIFEST_FILE += $(COMMON_PATH)/vintf/manifest.xml
# Framework compatibility matrix: What the device(=vendor) expects of the framework(=system)
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE += $(COMMON_PATH)/vintf/framework_compatibility_matrix.xml
DEVICE_MATRIX_FILE += $(COMMON_PATH)/vintf/compatibility_matrix.xml
ifneq ($(TARGET_USES_FINGERPRINT_V2_1),false)
DEVICE_MANIFEST_FILE += $(COMMON_PATH)/vintf/android.hardware.biometrics.fingerprint_v2.1.xml
endif

# New vendor security patch level: https://r.android.com/660840/
# Used by newer keymaster binaries
VENDOR_SECURITY_PATCH=$(PLATFORM_SECURITY_PATCH)

# Memory
MALLOC_SVELTE := true

# RIL
ENABLE_VENDOR_RIL_SERVICE := true

# QCOM
ifeq ($(PRODUCT_USES_QCOM_HARDWARE),true)
    include $(COMMON_PATH)/hardware/qcom/board.mk
endif
TARGET_USES_HARDWARE_QCOM_GPS := false

# USB
SOONG_CONFIG_NAMESPACES += MOTO_COMMON_USB MOTO_COMMON_POWER
SOONG_CONFIG_MOTO_COMMON_USB := USB_CONTROLLER_NAME
SOONG_CONFIG_MOTO_COMMON_USB_USB_CONTROLLER_NAME ?= 4e00000
SOONG_CONFIG_MOTO_COMMON_POWER := FB_IDLE_PATH
SOONG_CONFIG_MOTO_COMMON_POWER_FB_IDLE_PATH ?= /sys/devices/platform/soc/5e00000.qcom,mdss_mdp/idle_state
