LOCAL_PATH := $(call my-dir)
ifeq ($(PRODUCT_USES_QCOM_HARDWARE),true)
include $(call first-makefiles-under,$(LOCAL_PATH))
endif
