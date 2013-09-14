# Check for target product
ifeq (probam_find5,$(TARGET_PRODUCT))

# OVERLAY_TARGET adds overlay asset source
OVERLAY_TARGET := pa_xxhdpi

# AOKP device overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/probam/overlay/aokp/device/find5

# Copy bootanimation
PRODUCT_COPY_FILES += \
    vendor/probam/prebuilt/xxhdpi/bootanimation.zip:system/media/bootanimation.zip

# include ParanoidAndroid common configuration
include vendor/probam/config/probam_common.mk

# Inherit CM device configuration
$(call inherit-product, device/oppo/find5/cm.mk)

PRODUCT_NAME := probam_find5

endif
