LOCAL_PATH := $(call my-dir)

include $(MOTOROLA_CLEAR_VARS)
LOCAL_MODULE := libhidl_symlink
LOCAL_MODULE_PATH := $(TARGET_OUT_VENDOR)

MOTOROLA_SYMLINKS += \
    /vendor/lib64/android.hidl.base@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib64/android.hidl.base@1.0.so \
    /vendor/lib/android.hidl.base@1.0_vendor.so:$(TARGET_COPY_OUT_VENDOR)/lib/android.hidl.base@1.0.so
include $(MOTOROLA_BUILD_SYMLINKS)
