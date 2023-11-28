LOCAL_PATH := $(call my-dir)
ifneq ($(filter $(LOCAL_PATH),$(PRODUCT_SOONG_NAMESPACES)),)
ifneq ($(BUILD_WITHOUT_VENDOR), true)
include $(call all-subdir-makefiles,$(LOCAL_PATH))
endif
endif
