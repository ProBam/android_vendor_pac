# Check for target product
ifeq (probam_m7att,$(TARGET_PRODUCT))

# OVERLAY_TARGET adds overlay asset source
OVERLAY_TARGET := pa_xxhdpi

# AOKP device overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/probam/overlay/aokp/common

# Add bluefa1con bootanim
PRODUCT_COPY_FILES += \
    vendor/probam/prebuilt/xxhdpi/bootanimation.zip:system/media/bootanimation.zip

# include ProBam common configuration
include vendor/probam/config/probam_common.mk

# Inherit CM device configuration
$(call inherit-product, device/htc/m7att/cm.mk)

PRODUCT_NAME := probam_m7att

endif
