# Check for target product
ifeq (probam_mako,$(TARGET_PRODUCT))

# OVERLAY_TARGET adds overlay asset source
OVERLAY_TARGET := pa_nav_xhdpi

# AOKP device overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/probam/overlay/aokp/device/mako

# include ProBam common configuration
include vendor/probam/config/probam_common.mk

# Inherit CM device configuration
$(call inherit-product, device/lge/mako/cm.mk)

PRODUCT_NAME := probam_mako

# Update local_manifest.xml
GET_PROJECT_RMS := $(shell vendor/probam/tools/removeprojects.py $(PRODUCT_NAME))
GET_PROJECT_ADDS := $(shell vendor/probam/tools/addprojects.py $(PRODUCT_NAME))

endif
