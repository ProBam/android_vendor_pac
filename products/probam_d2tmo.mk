# Check for target product
ifeq (probam_d2tmo,$(TARGET_PRODUCT))

# OVERLAY_TARGET adds overlay asset source
OVERLAY_TARGET := pa_d2

# AOKP device overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/probam/overlay/aokp/device/d2-common

# Copy bootanimation
PRODUCT_COPY_FILES += \
    vendor/probam/prebuilt/xhdpi/bootanimation.zip:system/media/bootanimation.zip

# include ProBam common configuration
include vendor/probam/config/probam_common.mk

# Inherit CM device configuration
$(call inherit-product, device/samsung/d2tmo/cm.mk)

PRODUCT_NAME := probam_d2tmo

# Update local_manifest.xml
GET_PROJECT_RMS := $(shell vendor/probam/tools/removeprojects.py $(PRODUCT_NAME))
GET_PROJECT_ADDS := $(shell vendor/probam/tools/addprojects.py $(PRODUCT_NAME))

endif
