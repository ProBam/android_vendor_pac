# Check for target product
ifeq (probam_p880,$(TARGET_PRODUCT))

# OVERLAY_TARGET adds overlay asset source
OVERLAY_TARGET := pa_xhdpi

# include ParanoidAndroid common configuration
include vendor/probam/config/probam_common.mk

# Inherit CM device configuration
$(call inherit-product, device/lge/p880/cm.mk)

PRODUCT_NAME := probam_p880

# Update local_manifest.xml
GET_PROJECT_RMS := $(shell vendor/probam/tools/removeprojects.py $(PRODUCT_NAME))
GET_PROJECT_ADDS := $(shell vendor/probam/tools/addprojects.py $(PRODUCT_NAME))

endif
