# Check for target product
ifeq (probam_maguro,$(TARGET_PRODUCT))

# OVERLAY_TARGET adds overlay asset source
OVERLAY_TARGET := pa_nav_xhdpi

# AOKP device overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/probam/overlay/aokp/device/tuna

# Copy bootanimation
PRODUCT_COPY_FILES += \
    vendor/probam/prebuilt/xhdpi/bootanimation.zip:system/media/bootanimation.zip

# include ProBam common configuration
include vendor/probam/config/probam_common.mk

# Inherit CM device configuration
$(call inherit-product, device/samsung/maguro/cm.mk)

PRODUCT_NAME := probam_maguro

endif
