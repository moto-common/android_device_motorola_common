ifeq ($(PRODUCT_PLATFORM_MOT),true)

LOCAL_PATH := $(call my-dir)

include $(call all-subdir-makefiles)

endif
