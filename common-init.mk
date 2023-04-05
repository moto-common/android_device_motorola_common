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

# Common init scripts
PRODUCT_PACKAGES += \
    vendor_modprobe.sh

# Fingerprint init scripts
ifeq ($(TARGET_USES_FPC_FINGERPRINT),true)
PRODUCT_COPY_FILES += \
    $(COMMON_PATH)/fingerprint/android.hardware.biometrics.fingerprint@2.1-service-fpc2.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/android.hardware.biometrics.fingerprint@2.1-service-fpc2.rc
endif

ifeq ($(TARGET_USES_CHIPONE_FINGERPRINT),true)
PRODUCT_COPY_FILES += \
    $(COMMON_PATH)/fingerprint/android.hardware.biometrics.fingerprint@2.1-service-chipone2.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/android.hardware.biometrics.fingerprint@2.1-service-chipone2.rc
endif

ifeq ($(TARGET_USES_GOODIX_FINGERPRINT),true)
PRODUCT_COPY_FILES += \
    $(COMMON_PATH)/fingerprint/android.hardware.biometrics.fingerprint@2.1-goodixservice.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/android.hardware.biometrics.fingerprint@2.1-goodixservice.rc
endif

ifeq ($(TARGET_USES_EGISTEC_FINGERPRINT),true)
PRODUCT_COPY_FILES += \
    $(COMMON_PATH)/fingerprint/android.hardware.biometrics.fingerprint@2.1-service-ets2.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/android.hardware.biometrics.fingerprint@2.1-service-ets2.rc
endif

ifeq ($(TARGET_USES_SILEAD_FINGERPRINT),true)
PRODUCT_COPY_FILES += \
    $(COMMON_PATH)/fingerprint/android.hardware.biometrics.fingerprint@2.1-service-silead2.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/android.hardware.biometrics.fingerprint@2.1-service-silead2.rc
endif

ifeq ($(TARGET_USES_FOCAL_FINGERPRINT),true)
PRODUCT_COPY_FILES += \
    $(COMMON_PATH)/fingerprint/android.hardware.biometrics.fingerprint@2.1-focalservice.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/android.hardware.biometrics.fingerprint@2.1-focalservice.rc
endif
