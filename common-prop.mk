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

# Audio (newer CAF HALs)
PRODUCT_ODM_PROPERTIES += \
    persist.vendor.audio.fluence.speaker=false \
    persist.vendor.audio.fluence.voicecall=true \
    persist.vendor.audio.fluence.voicecomm=true \
    persist.vendor.audio.fluence.voicerec=false \
    ro.vendor.audio.sdk.fluencetype=fluence

# Bluetooth
PRODUCT_PROPERTY_OVERRIDES += \
    bluetooth.profile.asha.central.enabled=true \
    bluetooth.profile.a2dp.source.enabled=true \
    bluetooth.profile.avrcp.target.enabled=true \
    bluetooth.profile.bas.client.enabled=true \
    bluetooth.profile.gatt.enabled=true \
    bluetooth.profile.hfp.ag.enabled=true \
    bluetooth.profile.hid.device.enabled=true \
    bluetooth.profile.hid.host.enabled=true \
    bluetooth.profile.map.server.enabled=true \
    bluetooth.profile.opp.enabled=true \
    bluetooth.profile.pan.nap.enabled=true \
    bluetooth.profile.pan.panu.enabled=true \
    bluetooth.profile.pbap.server.enabled=true \
    bluetooth.profile.sap.server.enabled=true \
    bluetooth.profile.tbs.server.enabled=true \
    bluetooth.profile.vc.server.enabled=true

## Set the Bluetooth Class of Device
# Service Field: 0x5A -> 90
#    Bit 17: Networking
#    Bit 19: Capturing
#    Bit 20: Object Transfer
#    Bit 22: Telephony
# MAJOR_CLASS: 0x02 -> 2 (Phone)
# MINOR_CLASS: 0x0C -> 12 (Smart Phone)
PRODUCT_PRODUCT_OVERRIDES += \
    bluetooth.device.class_of_device=90,2,12

# Camera
PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.camera.expose.aux=1

# Dalvik
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.heapstartsize=8m \
    dalvik.vm.heapgrowthlimit=192m \
    dalvik.vm.heapsize=512m \
    dalvik.vm.heaptargetutilization=0.6 \
    dalvik.vm.heapminfree=8m \
    dalvik.vm.heapmaxfree=16m

# Dex2oat
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.dex2oat64.enabled=true \
    dalvik.vm.dex2oat-threads=6 \
    dalvik.vm.image-dex2oat-threads=6

# Display
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.product.model=$(PRODUCT_MODEL)

# DRM service
PRODUCT_PROPERTY_OVERRIDES += \
    drm.service.enabled=true

# Encryption
## Avoid Adoptable double encryption
PRODUCT_PROPERTY_OVERRIDES += \
    ro.crypto.allow_encrypt_override=true

## Enforce use of new dm-default-key API
PRODUCT_PROPERTY_OVERRIDES += \
    ro.crypto.volume.metadata.method=dm-default-key \
    ro.crypto.dm_default_key.options_format.version=2 \
    ro.crypto.volume.options=::v2

## Reduce cost of scrypt for FBE CE decryption
PRODUCT_PROPERTY_OVERRIDES += \
    ro.crypto.scrypt_params=15:3:1

# FUSE passthrough
PRODUCT_PRODUCT_PROPERTIES += \
    persist.sys.fuse.passthrough.enable=true

# Hardware
ifeq ($(PRODUCT_USES_QCOM_HARDWARE),true)
  PRODUCT_PROPERTY_OVERRIDES += \
      ro.vendor.hardware=qcom
else ifeq ($(PRODUCT_USES_MTK_HARDWARE),true)
  PRODUCT_PROPERTY_OVERRIDES += \
      ro.vendor.hardware=mtk
else
  $(warning Neither MTK nor QCOM hardware has been selected!)
  PRODUCT_PROPERTY_OVERRIDES += \
      ro.vendor.hardware=unknown
endif

# HFR
ifeq ($(call device-has-characteristic, hfr),true)
   PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
        ro.surface_flinger.set_idle_timer_ms=250 \
        ro.surface_flinger.set_touch_timer_ms=1000 \
        ro.surface_flinger.set_display_power_timer_ms=1000 \
        ro.surface_flinger.use_smart_90_for_video=true \
        ro.surface_flinger.refresh_rate_switching=true
endif

# LMKd
PRODUCT_PROPERTY_OVERRIDES += \
    ro.lmk.thrashing_limit=30 \
    ro.lmk.swap_free_low_percentage=10 \
    ro.lmk.psi_partial_stall_ms=200 \
    ro.lmk.swap_util_max=100 \
    ro.lmk.threshold_decay=30 \
    ro.lmk.thrashing_limit_decay=50 \
    ro.lmk.critical_upgrade=true \
    ro.lmk.upgrade_pressure=40 \
    ro.lmk.downgrade_pressure=60

# Kernel
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.kernel_version=$(TARGET_KERNEL_VERSION)

# Media
PRODUCT_PRODUCT_PROPERTIES += \
    media.settings.xml=/vendor/etc/media_profiles_vendor.xml

# One Handed-Mode
PRODUCT_PRODUCT_OVERRIDES += \
    ro.support_one_handed_mode=true

# Power HAL
ifeq ($(PRODUCT_USES_MTK_HARDWARE),true)
  PRODUCT_PROPERTY_OVERRIDES += \
    vendor.powerhal.disp.idle_support=false
endif

# Priv-app permisisons
PRODUCT_PROPERTY_OVERRIDES += \
    ro.control_privapp_permissions=enforce

# Recovery
PRODUCT_VENDOR_PROPERTIES += \
    ro.recovery.usb.vid=22B8 \
    ro.recovery.usb.adb.pid=2E81 \
    ro.recovery.usb.fastboot.pid=2E81

# RIL
PRODUCT_PROPERTY_OVERRIDES += \
    ril.subscription.types=NV,RUIM

## Enable advanced power saving for data connectivity
PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.dpm.feature=1 \
    persist.vendor.dpm.tcm=1 \
    persist.vendor.cne.feature=1

## Enable Power save functionality for modem
PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.radio.add_power_save=1 \
    persist.vendor.radio.apm_sim_not_pwdn=1

## IMS
PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.radio.vdp_on_ims_cap=1 \
    persist.vendor.radio.report_codec=1

## Modem properties
PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.radio.wait_for_pbm=1 \
    persist.vendor.radio.mt_sms_ack=19 \
    persist.vendor.radio.enableadvancedscan=true \
    persist.vendor.radio.unicode_op_names=true \
    persist.vendor.radio.sib16_support=1 \
    persist.vendor.radio.oem_socket=true \
    persist.vendor.radio.msgtunnel.start=true

## Platform specific default properties
PRODUCT_PROPERTY_OVERRIDES += \
    persist.data.qmi.adb_logmask=0

## RemoteFS Storage
# This property is needed for rmt_storage to look for fsg
# in /vendor
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.build.vendorprefix=/vendor

## System props for the data modules
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.use_data_netmgrd=true \
    persist.vendor.data.mode=concurrent

## The default value of this variable is false and should only be set to true when
## the device allows users to retain eSIM profiles after factory reset of user data.
PRODUCT_PRODUCT_PROPERTIES += \
    masterclear.allow_retain_esim_profiles_after_fdr=true

## VoLTE / VT / WFC
PRODUCT_PROPERTY_OVERRIDES += \
    persist.dbg.volte_avail_ovr=1 \
    persist.dbg.vt_avail_ovr=1  \
    persist.dbg.wfc_avail_ovr=1

# Stagefright
PRODUCT_PROPERTY_OVERRIDES += \
    media.stagefright.thumbnail.prefer_hw_codecs=true

# SurfaceFlinger
PRODUCT_PROPERTY_OVERRIDES += \
    ro.surface_flinger.enable_frame_rate_override=false

# USB
PRODUCT_PROPERTY_OVERRIDES += \
    vendor.usb.contaminantdisable=true \
    vendor.usb.signalingdisable=true

# Disable Compressed APEX on 4.14 kernel as Android 12 enforces it and our kernel is not compatible (yet)
ifeq ($(TARGET_KERNEL_VERSION), 4.14)
  OVERRIDE_PRODUCT_COMPRESSED_APEX := false
endif
