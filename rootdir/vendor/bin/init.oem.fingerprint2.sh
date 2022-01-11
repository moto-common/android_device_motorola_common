#!/vendor/bin/sh
# Determine fingerprint sensor
if [ ! -f /mnt/vendor/persist/fps/vendor_id ];
then
fps_id=`cat /proc/config/fps_id/ascii`
else
fps_id=`cat /mnt/vendor/persist/fps/vendor_id`
fi
# use this to trigger init.mmi.rc
prop_fps_ident=vendor.hw.fps.ident
# Set fingerprint vendor
prop_persist_fps=persist.vendor.hardware.fingerprint
# this property store FPS_STATUS_NONE or FPS_STATUS_OK
# after start fingerprint hal service, the hal service will set this property.
prop_fps_status=vendor.hw.fingerprint.status

function set_permissions() {
    if [ $fps_id == "chipone" ]
    then
        chmod 0660 /dev/fpsensor
        chown system:system /dev/fpsensor
    elif [ $fps_id == "fpc" ]
    then
        chown system:system /sys/class/fingerprint/fpc1020/irq
    fi
}

function start_fpsensor() {
    if [ $fps_id == "chipone" ]
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
            setprop $prop_persist_fps $fps_id
        fi
    elif [ $fps_id == "fpc" ]
    then
        insmod /vendor/lib/modules/fpc1020_mmi.ko
        sleep 0.6
        set_permissions
        sleep 0.4
        start fps_hal
        sleep 1
        value=`getprop $prop_fps_status`
        if [ $value == "ok" ];
        then
            setprop $prop_persist_fps $fps_id
        fi
    else
        insmod /vendor/lib/modules/ets_fps_mmi.ko
        sleep 0.6
        start ets_hal
        sleep 1
        value=`getprop $prop_fps_status`
        if [ $value == "ok" ];
        then
            setprop $prop_persist_fps $fps_id
        fi
    fi
}

rmmod ets_fps_mmi
rmmod fpsensor_spi_tee
rmmod fpc1020_mmi
sleep 0.5
if [ $fps_id == "none" ];
then
    fps_id=`cat /mnt/vendor/persist/fps/last_vendor_id`
fi
start_fpsensor
