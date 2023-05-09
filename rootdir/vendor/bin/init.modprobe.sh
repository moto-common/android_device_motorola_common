#!/vendor/bin/sh
if [ -f "/vendor/lib/modules/modules.load" ]; then
    exit 0
fi

MODULES_PATH="/vendor/lib/modules/"
MODULES=$(/vendor/bin/modprobe -d ${MODULES_PATH} -l)

# Iterate over module list and modprobe them in background.
for MODULE in ${MODULES}; do
	/vendor/bin/modprobe -a -b -d ${MODULES_PATH} "${MODULE}" &
done

# Wait until all the modprobes are finished
wait
