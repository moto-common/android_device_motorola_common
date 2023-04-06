#!/vendor/bin/sh
echo 1 > /proc/hw/reload
exclude_dirs=("all" "reload")

for dir in /proc/hw/*; do
    exclude=0
    for exclude_dir in "${exclude_dirs[@]}"; do
        if [ "$(basename "$dir")" = "$exclude_dir" ]; then
            exclude=1
            break
        fi
    done

    if [ "$exclude" -eq 0 ]; then
        ascii=$(cat "$dir/ascii")
        if [ -z "$ascii" ]; then
            continue
        fi
        echo "ro.vendor.hw.${dir:9}" "$ascii"
        setprop "ro.vendor.hw.${dir:9}" "$ascii"
    fi
done
