# Check for target product
ifeq (probam_i9305,$(TARGET_PRODUCT))

# OVERLAY_TARGET adds overlay asset source
OVERLAY_TARGET := pa_xhdpi

# AOKP device overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/probam/overlay/aokp/device/i9305

# include ProBam common configuration
include vendor/probam/config/pac_common.mk

# Inherit CM device configuration
$(call inherit-product, device/samsung/i9305/cm.mk)

PRODUCT_NAME := probam_i9305

# Update local_manifest.xml
GET_PROJECT_RMS := $(shell vendor/probam/tools/removeprojects.py $(PRODUCT_NAME))
GET_PROJECT_ADDS := $(shell vendor/probam/tools/addprojects.py $(PRODUCT_NAME))

endif
