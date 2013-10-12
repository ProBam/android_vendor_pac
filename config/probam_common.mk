# Vendor hack
#   $1 = vendor name
#   $2 = product name
define vendor-replace
  $(shell mkdir -p vendor/$(1); \
          rm -rf vendor/$(1)/$(2); \
          ln -sf ../$(1)-extra/$(2) vendor/$(1)/$(2))
endef

# use AOSP default sounds
PRODUCT_PROPERTY_OVERRIDES += \
  ro.config.ringtone=Themos.ogg \
  ro.config.notification_sound=Proxima.ogg \
  ro.config.alarm_alert=Cesium.ogg

# Backup Tool
PRODUCT_COPY_FILES += \
  vendor/probam/prebuilt/common/bin/backuptool.sh:system/bin/backuptool.sh \
  vendor/probam/prebuilt/common/bin/backuptool.functions:system/bin/backuptool.functions \
  vendor/probam/prebuilt/common/bin/50-backupScript.sh:system/addon.d/50-backupScript.sh

# T-Mobile theme engine
  include vendor/probam/config/themes_common.mk

# Using Custom ReleaseRool
TARGET_RELEASETOOL_OTA_FROM_TARGET_SCRIPT := vendor/probam/overlay/build/tools/releasetools/ota_from_target_files

# init.d support
PRODUCT_COPY_FILES += \
    vendor/probam/prebuilt/common/etc/init.d/00check:system/etc/init.d/00check \
    vendor/probam/prebuilt/common/etc/init.d/01zipalign:system/etc/init.d/01zipalign \
    vendor/probam/prebuilt/common/etc/init.d/02sysctl:system/etc/init.d/02sysctl \
    vendor/probam/prebuilt/common/etc/init.d/03firstboot:system/etc/init.d/03firstboot \
    vendor/probam/prebuilt/common/etc/init.d/05freemem:system/etc/init.d/05freemem \
    vendor/probam/prebuilt/common/etc/init.d/06removecache:system/etc/init.d/06removecache \
    vendor/probam/prebuilt/common/etc/init.d/07fixperms:system/etc/init.d/07fixperms \
    vendor/probam/prebuilt/common/etc/init.d/09cron:system/etc/init.d/09cron \
    vendor/probam/prebuilt/common/etc/init.d/10sdboost:system/etc/init.d/10sdboost \
    vendor/probam/prebuilt/common/etc/init.d/98tweaks:system/etc/init.d/98tweaks \
    vendor/probam/prebuilt/common/etc/helpers.sh:system/etc/helpers.sh \
    vendor/probam/prebuilt/common/etc/sysctl.conf:system/etc/sysctl.conf \
    vendor/probam/prebuilt/common/etc/init.d.cfg:system/etc/init.d.cfg

# Added xbin files
PRODUCT_COPY_FILES += \
    vendor/probam/prebuilt/common/xbin/zip:system/xbin/zip \
    vendor/probam/prebuilt/common/xbin/zipalign:system/xbin/zipalign

# PROBAM Overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/probam/overlay/probam/common

# AOKP Overlays
  PRODUCT_PACKAGE_OVERLAYS += vendor/probam/overlay/aokp/common

# ProBam Packages
PRODUCT_PACKAGES += \
  ProBamStats \
  Focal \
  ProbamUpdater
  
### PARANOID ###
# PARANOID Packages
PRODUCT_PACKAGES += \
  HALO 

# ParanoidAndroid Overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/pa/overlay/common
PRODUCT_PACKAGE_OVERLAYS += vendor/pa/overlay/$(TARGET_PRODUCT)

# Allow device family to add overlays and use a same prop.conf
ifneq ($(OVERLAY_TARGET),)
    PRODUCT_PACKAGE_OVERLAYS += vendor/pa/overlay/$(OVERLAY_TARGET)
    PA_CONF_SOURCE := $(OVERLAY_TARGET)
else
    PA_CONF_SOURCE := $(TARGET_PRODUCT)
endif

# ParanoidAndroid Proprietary
PRODUCT_COPY_FILES += \
    vendor/pa/prebuilt/common/apk/ParanoidPreferences.apk:system/app/ParanoidPreferences.apk \
    vendor/probam/prebuilt/pa/$(PA_CONF_SOURCE).conf:system/etc/paranoid/properties.conf \
    vendor/probam/prebuilt/pa/$(PA_CONF_SOURCE).conf:system/etc/paranoid/backup.conf

BOARD := $(subst probam_,,$(TARGET_PRODUCT))

# Add CM release version
CM_RELEASE := true
CM_BUILD := $(BOARD)

# Add PA release version
PA_VERSION_MAJOR = 3
PA_VERSION_MINOR = 9
PA_VERSION_MAINTENANCE = 9-RC2
PA_PREF_REVISION = 1
VERSION := $(PA_VERSION_MAJOR).$(PA_VERSION_MINOR)$(PA_VERSION_MAINTENANCE)
PA_VERSION := pa_$(BOARD)-$(VERSION)

# PROBAM version
PROBAM_VERSION_MAJOR = 4
PROBAM_VERSION_MINOR = 4
PROBAM_VERSION_MAINTENANCE = 9
PROBAM_VERSION := $(PROBAM_VERSION_MAJOR).$(PROBAM_VERSION_MINOR).$(PROBAM_VERSION_MAINTENANCE)

# PAC version
PAC_VERSION_MAJOR = 4
PAC_VERSION_MINOR = 3
PAC_VERSION_MAINTENANCE = 1
PAC_VERSION := $(PAC_VERSION_MAJOR).$(PAC_VERSION_MINOR).$(PAC_VERSION_MAINTENANCE)

PRODUCT_PROPERTY_OVERRIDES += \
  ro.probam.version=$(PROBAM_VERSION) \
  ro.probamrom.version=probam_v$(PROBAM_VERSION)_$(BOARD) \
  ro.timestamp=$(shell date +%s) \
  ro.pac.version=$(PAC_VERSION) \
  ro.pacrom.version=pac_$(BOARD)_4.3-$(PAC_VERSION) \
  ro.modversion=$(PA_VERSION) \
  ro.pa.family=$(PA_CONF_SOURCE) \
  ro.pa.version=$(VERSION) \
  ro.papref.revision=$(PA_PREF_REVISION) \
  ro.aokp.version=$(BOARD)_jb-mr2

# ROMStats Properties
PRODUCT_PROPERTY_OVERRIDES += \
  ro.probamstats.url=http://stats.codexc.com \
  ro.probamstats.name=ProBam \
  ro.probamstats.version=$(PROBAM_VERSION) \
  ro.probamstats.tframe=1

# ProBam Tweaks
ADDITIONAL_DEFAULT_PROPERTIES += \
  ro.config.hw_quickpoweron=true \
  persist.sys.shutdown.mode=hibernate \
  dev.bootcomplete=0 \
  ro.config.vc_call_steps=20

# Disable ADB authentication and set root access to Apps and ADB
ADDITIONAL_DEFAULT_PROPERTIES += \
    ro.adb.secure=0 \
    persist.sys.root_access=3
