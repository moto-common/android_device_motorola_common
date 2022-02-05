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

# TEMPORARY: These libraries are deprecated, not referenced by any AOSP
# nor OSS HAL We don't add a dependency on the vndk variants as those
# end up in /system but require these in /vendor instead:
PRODUCT_PACKAGES += \
    libhwbinder.vendor \
    libhidltransport.vendor

# Audio
PRODUCT_PACKAGES += \
    audio.a2dp.default \
    audio.bluetooth.default \
    audio.hearing_aid.default \
    audio.r_submix.default \
    audio.usb.default \
    libaudio-resampler

# For audio.primary
PRODUCT_PACKAGES += \
    libtinyalsa \
    libaudioroute \
    tinymix

# Audio effects
PRODUCT_PACKAGES += \
    libqcomvisualizer \
    libqcomvoiceprocessing \
    libqcompostprocbundle

# Audio deps
PRODUCT_PACKAGES += \
    libfmq

# The following modules are included in debuggable builds only.
PRODUCT_PACKAGES_DEBUG += \
    bootctl \
    update_engine_client

# GFX
PRODUCT_PACKAGES += \
    libhdmi \
    libqdutils \
    libqdMetaData

# OMX
PRODUCT_PACKAGES += \
    libc2dcolorconvert \
    libstagefrighthw \
    libOmxCore \
    libmm-omxcore \
    libOmxVdec \
    libOmxVdecHevc \
    libOmxVenc

# GPS
PRODUCT_PACKAGES += \
    flp.conf \
    gnss@2.0-base.policy \
    gnss@2.0-xtra-daemon.policy \
    gnss@2.0-xtwifi-client.policy \
    gnss@2.0-xtwifi-inet-agent.policy \
    gnss_antenna_info.conf \
    gps.conf \
    libbatching \
    libgeofencing \
    libgnss

# Location
PRODUCT_PACKAGES += \
    libloc_api_v02 \
    libgnsspps \
    libsynergy_loc_api

# IMS (OSS)
PRODUCT_PACKAGES += \
    qti-telephony-hidl-wrapper \
    qti_telephony_hidl_wrapper.xml \
    qti-telephony-utils \
    qti_telephony_utils.xml \
    telephony-ext \
    ims-ext-common \
    ims_ext_common.xml

# IPA
PRODUCT_PACKAGES += \
    IPACM_cfg.xml \
    ipacm

# WLAN
PRODUCT_PACKAGES += \
    hostapd \
    libwpa_client \
    wpa_supplicant \
    wpa_supplicant.conf \
    libwpa_client

# Camera
#PRODUCT_PACKAGES += \

# Media
PRODUCT_PACKAGES += \
    libavservices_minijail.vendor

# OSS Time service
PRODUCT_PACKAGES += \
    timekeep \
    TimeKeep \

# Carrier configuration
PRODUCT_PACKAGES += \
    CarrierConfig

# QCOM Data
PRODUCT_PACKAGES += \
    librmnetctl

# RIL
PRODUCT_PACKAGES += \
    ims-moto-libs \
    libandroid_net \
    libjson \
    libprotobuf-cpp-full \
    libsensorndkbridge \
    moto-ims-ext \
    moto-telephony \
    qcrilhook \
    qti-telephony-hidl-wrapper \
    qti_telephony_hidl_wrapper.xml \
    qti-telephony-utils \
    qti_telephony_utils.xml

PRODUCT_BOOT_JARS += \
    ims-moto-libs \
    qcrilhook

# MotoActions
PRODUCT_PACKAGES += \
    MotoActions

# FIXME: master: compat for libprotobuf
# See https://android-review.googlesource.com/c/platform/prebuilts/vndk/v28/+/1109518
PRODUCT_PACKAGES += \
    libprotobuf-cpp-full-vendorcompat

# RenderScript
PRODUCT_PACKAGES += \
    librsjni

# libRSDriver_adreno dependency
PRODUCT_PACKAGES += \
    libLLVM

# Charger
PRODUCT_PACKAGES += \
    charger_res_images

# AOSP Packages
PRODUCT_PACKAGES += \
    Launcher3QuickStep \
    libion \
    libjson \
    libxml2 \

# External exFat tools
PRODUCT_PACKAGES += \
    mkfs.exfat \
    fsck.exfat

# For config.fs
PRODUCT_PACKAGES += \
    fs_config_files \
    fs_config_dirs

# HIDL
PRODUCT_PACKAGES += \
    android.hidl.base@1.0 \
    android.hidl.base@1.0.vendor
