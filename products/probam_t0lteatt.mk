# Check for target product
ifeq (probam_t0lteatt,$(TARGET_PRODUCT))

# OVERLAY_TARGET adds overlay asset source
OVERLAY_TARGET := pa_xhdpi

# AOKP device overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/probam/overlay/aokp/device/t0lteatt

# include ProBam common configuration
include vendor/probam/config/probam_common.mk

# Inherit CM device configuration
$(call inherit-product, device/samsung/t0lteatt/cm.mk)

PRODUCT_NAME := probam_t0lteatt

endif
