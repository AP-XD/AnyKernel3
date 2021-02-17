# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string=StormBreaker Kernel
maintainer.string1=ItsVixano TG:@GiovanniRN5
maintainer.string2=Saalim Quadri, Team StormBreaker Head
do.devicecheck=1
do.modules=0
do.systemless=1
do.cleanup=1
do.cleanuponabort=0
device.name1=ysl
supported.versions=
supported.patchlevels=
'; } # end properties

# shell variables
block=/dev/block/bootdevice/by-name/boot;
is_slot_device=0;
ramdisk_compression=auto;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. tools/ak3-core.sh;

# The uclamp script base
UCLAMP_SCRIPT="/tmp/anykernel/tools/uclamp.txt"

# Path of init.qcom.post_boot.sh
ROOTDIR_PATH="/vendor/bin/init.qcom.post_boot.sh"
ROOTDIR_PATH_BK="/vendor/bin/init.qcom.post_boot.sh_bk"

# Let's install it
ui_print "[-] Installing on-boot execution script"
mount -o remount,rw /vendor

# Before going, let's see if "ROOTDIR_PATH_BK" is there "uncomment in case of script update"
#if [ ! -d "$ROOTDIR_PATH_BK" ]
#then
     #in case of script update, uncomment this
     #rm -rf "$ROOTDIR_PATH"
     #cp "$ROOTDIR_PATH_BK" "$ROOTDIR_PATH"
#fi

# Before really installing it, let's see if the script is already there
if grep Uclamp "$ROOTDIR_PATH"
then
    ui_print "[!] Script is already present on "$ROOTDIR_PATH""
    ui_print "[!] Aborting"
    umount /vendor
else
    cp "$ROOTDIR_PATH" "$ROOTDIR_PATH_BK"
    cat "$UCLAMP_SCRIPT" >> "$ROOTDIR_PATH"
    chmod u+x "$ROOTDIR_PATH"
    umount /vendor
    ui_print "[-] Done"
fi

## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
set_perm_recursive 0 0 755 644 $ramdisk/*;
set_perm_recursive 0 0 750 750 $ramdisk/init* $ramdisk/sbin;

## AnyKernel install
dump_boot;

write_boot;
## end install

