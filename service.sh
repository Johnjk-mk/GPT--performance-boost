#!/system/bin/sh
MODDIR=${0%/*}

# Wait for system boot to complete
until [ "$(getprop sys.boot_completed)" = "1" ]; do
    sleep 5
done

sleep 10

# ------------------------------------
# Hardware & CPU Cluster Detection
# ------------------------------------
SOC_MODEL=$(getprop ro.soc.model)
[ -z "$SOC_MODEL" ] && SOC_MODEL=$(getprop ro.hardware)

# Enable Touch Sampling & Response Tweaks
for touch_node in /sys/class/touch/touch_dev/gestures /sys/devices/platform/soc/*.touch/touch_boost; do
    if [ -f "$touch_node" ]; then
        echo "1" > "$touch_node" 2>/dev/null
    fi
done

# Set IO Scheduler to Performance / Deadline if available
for block_dev in /sys/block/sd*/queue/scheduler /sys/block/dm-*/queue/scheduler; do
    if [ -f "$block_dev" ]; then
        echo "performance" > "$block_dev" 2>/dev/null || echo "deadline" > "$block_dev" 2>/dev/null
    fi
done

# ------------------------------------
# Dynamic Thermal & Performance Loop
# ------------------------------------
while true; do
    # Get Battery Temperature (in tenths of °C, e.g., 410 = 41°C)
    BAT_TEMP=$(cat /sys/class/power_supply/battery/temp 2>/dev/null)
    [ -z "$BAT_TEMP" ] && BAT_TEMP=300

    if [ "$BAT_TEMP" -gt 430 ]; then
        # Thermal Throttling Mitigation: Rest back to balanced to prevent overheating
        for gov in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do
            echo "schedutil" > "$gov" 2>/dev/null
        done
    else
        # Optimal Thermal State: Apply Performance scaling
        for gov in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do
            echo "performance" > "$gov" 2>/dev/null
        done
    fi

    # RAM Management: Purge cached memory periodically if free RAM is low
    MEM_FREE_MB=$(free -m | awk '/Mem:/ {print $4}')
    if [ "$MEM_FREE_MB" -lt 500 ]; then
        sync
        echo 3 > /proc/sys/vm/drop_caches
    fi

    sleep 15
done
