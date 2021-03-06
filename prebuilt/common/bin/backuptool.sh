#!/sbin/sh
#
# Backup and restore addon /system files
#

export C=/tmp/backup
export S=/system

# Preserve /system/addon.d in /tmp/addon.d
preserve_addon_d() {
  mkdir -p /tmp/addon.d/
  cp -a /system/addon.d/* /tmp/addon.d/
  chmod 755 /tmp/addon.d/*.sh
}

# Restore /system/addon.d in /tmp/addon.d
restore_addon_d() {
  cp -a /tmp/addon.d/* /system/addon.d/
  rm -rf /tmp/addon.d/
}

# Backup Xposed Framework (bin/app_process)
xposed_backup()
{
	if [ -f /system/bin/app_process.orig ]
		then
			cp /system/bin/app_process /tmp/backup/
	fi
}

# Restore Xposed Framework (bin/app_process)
xposed_restore()
{
	if [ -f /tmp/backup/app_process ]
		then
			mv /system/bin/app_process /system/bin/app_process.orig
			cp /tmp/backup/app_process /system/bin/
	fi
}

# Execute /system/addon.d/*.sh scripts with $1 parameter
run_stage() {
for script in $(find /tmp/addon.d/ -name '*.sh' |sort -n); do
  $script $1
done
}

case "$1" in
  backup)
    mkdir -p $C
    xposed_backup
    preserve_addon_d
    run_stage pre-backup
    run_stage backup
    run_stage post-backup
  ;;
  restore)
    xposed_restore
    run_stage pre-restore
    run_stage restore
    run_stage post-restore
    restore_addon_d
    rm -rf $C
    rm -rf /data/data/android.probamstats
    rm -rf /system/app/OTAPlatform.apk
    rm -rf /system/app/UpdateMe.apk
    rm -rf /data/dalvik-cache/*com.beerbong.otaplatform*
    rm -rf /data/dalvik-cache/*com.acquariusoft.UpdateMe*
    rm -rf /data/app/com.acquariusoft.UpdateMe-*
    rm -rf /data/app/com.beerbong.otaplatform*-*
    sync
  ;;
  *)
    echo "Usage: $0 {backup|restore}"
    exit 1
esac

exit 0
