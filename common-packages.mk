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
    audio.bluetooth.default \
    libtinyalsa \
    tinymix

# Audio deps
PRODUCT_PACKAGES += \
    libfmq

# The following modules are included in debuggable builds only.
PRODUCT_PACKAGES_DEBUG += \
    bootctl \
    update_engine_client

# IMS (OSS)
PRODUCT_PACKAGES += \
    telephony-ext \
    ims-ext-common \
    ims_ext_common.xml

# Media
PRODUCT_PACKAGES += \
    libavservices_minijail.vendor

# OSS Time service
PRODUCT_PACKAGES += \
    timekeep \
    TimeKeep \

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
    qti-telephony-hidl-wrapper-prd \
    qti_telephony_hidl_wrapper.xml \
    qti_telephony_hidl_wrapper_prd.xml \
    qti-telephony-utils \
    qti_telephony_utils.xml

# MotoActions
PRODUCT_PACKAGES += \
    MotoActions

# FIXME: master: compat for libprotobuf
# See https://android-review.googlesource.com/c/platform/prebuilts/vndk/v28/+/1109518
PRODUCT_PACKAGES += \
    libprotobuf-cpp-full-vendorcompat

# Charger
PRODUCT_PACKAGES += \
    charger_res_images

# AOSP Packages
PRODUCT_PACKAGES += \
    libion \
    libxml2 \

# For config.fs
PRODUCT_PACKAGES += \
    fs_config_files \
    fs_config_dirs

# HIDL
PRODUCT_PACKAGES += \
    android.hidl.base@1.0 \
    android.hidl.base@1.0.vendor

# FM
PRODUCT_PACKAGES += \
    FM2 \
    libfm-hci \
    libqcomfm_jni \
    fm_helium \
    qcom.fmradio

# RIL
PRODUCT_PACKAGES += \
    libqsap_sdk

# Power
ifeq ($(BOARD_USES_PIXEL_POWER_HAL),true)
PRODUCT_PACKAGES += \
    libperfmgr.vendor
endif
