# Check for target product
ifeq (probam_toroplus,$(TARGET_PRODUCT))

# OVERLAY_TARGET adds overlay asset source
OVERLAY_TARGET := pa_nav_xhdpi

# AOKP device overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/probam/overlay/aokp/device/tuna

# include ProBam common configuration
include vendor/probam/config/probam_common.mk

# Inherit CM device configuration
$(call inherit-product, device/samsung/toroplus/cm.mk)

PRODUCT_NAME := probam_toroplus

endif
