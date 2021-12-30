#!/vendor/bin/sh
# At the current boot, what is the fingerprint sensor
persist_fps_id=`cat /mnt/vendor/persist/fps/vendor_id`
# use this to trigger init.mmi.rc
prop_fps_ident=vendor.hw.fps.ident
# if $prop_fps_status=$FPS_STATUS_OK, then will set prop_persist_fps to the specific vendor name.
prop_persist_fps=`getprop persist.vendor.hardware.fingerprint`
# this property store FPS_STATUS_NONE or FPS_STATUS_OK
# after start fingerprint hal service, the hal service will set this property.
prop_fps_status=vendor.hw.fingerprint.status

function set_permissions() {
    if [ $persist_fps_id == "chipone" ];
    then
        chmod 0660 /dev/fpsensor
        chown system:system /dev/fpsensor
    fi
}

function start_fpsensor() {
    if [ $persist_fps_id == "chipone" ];
    then
        insmod /vendor/lib/modules/fpsensor_spi_tee.ko
        sleep 0.6
        set_permissions
        sleep 0.4
        start chipone_fp_hal
        sleep 1
        value=`getprop $prop_fps_status`
        if [ $value == "ok" ];
        then
            setprop $prop_persist_fps $persist_fps_id
        fi
    else
        insmod /vendor/lib/modules/fpc1020_mmi.ko
        sleep 0.6
        start fps_hal
        sleep 1
        value=`getprop $prop_fps_status`
        if [ $value == "ok" ];
        then
            setprop $prop_persist_fps $persist_fps_id
        fi
    fi
}

rmmod fpsensor_spi_tee
rmmod fpc1020_mmi
sleep 0.5
if [ $persist_fps_id == "none" ];
then
    persist_fps_id=`cat /mnt/vendor/persist/fps/last_vendor_id`
fi
start_fpsensor
