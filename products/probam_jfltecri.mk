# Check for target product
ifeq (probam_jfltecri,$(TARGET_PRODUCT))

# OVERLAY_TARGET adds overlay asset source
OVERLAY_TARGET := pa_xxhdpi

# AOKP device overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/probam/overlay/aokp/device/jfltecri



# include ProBam common configuration
include vendor/probam/config/probam_common.mk

# Inherit CM device configuration
$(call inherit-product, device/samsung/jfltecri/cm.mk)

PRODUCT_NAME := probam_jfltecri

# Update local_manifest.xml
GET_PROJECT_RMS := $(shell vendor/probam/tools/removeprojects.py $(PRODUCT_NAME))
GET_PROJECT_ADDS := $(shell vendor/probam/tools/addprojects.py $(PRODUCT_NAME))

endif
