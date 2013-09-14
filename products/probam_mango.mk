# Check for target product
ifeq (probam_mango,$(TARGET_PRODUCT))

# OVERLAY_TARGET adds overlay asset source
OVERLAY_TARGET := pa_mdpi

# AOKP device overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/probam/overlay/aokp/device/mango

# PROBAM device overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/probam/overlay/probam/mdpi

# PAC boot logo
PRODUCT_COPY_FILES += \
    vendor/probam/prebuilt/common/bootlogo/sony-probam_320x480.rle:root/logo.rle



# include ProBam common configuration
include vendor/probam/config/probam_common.mk

# Inherit CM device configuration
$(call inherit-product, device/semc/mango/cm.mk)

PRODUCT_NAME := probam_mango

# Update local_manifest.xml
GET_PROJECT_RMS := $(shell vendor/probam/tools/removeprojects.py $(PRODUCT_NAME))
GET_PROJECT_ADDS := $(shell vendor/probam/tools/addprojects.py $(PRODUCT_NAME))

endif
