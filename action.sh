#!/system/bin/sh
MODDIR=${0%/*}

CMD="$1"

case "$CMD" in
    "boost")
        # Direct RAM Purge
        sync
        echo 3 > /proc/sys/vm/drop_caches
        
        # Maximize GPU Power Tier
        for gpu_node in /sys/class/kgsl/kgsl-3d0/devfreq/governor /sys/devices/platform/soc/*.qcom,kgsl-3d0/devfreq/governor; do
            [ -f "$gpu_node" ] && echo "performance" > "$gpu_node" 2>/dev/null
        done
        
        echo "SUCCESS: Extreme Boost Applied & Cache Purged"
        ;;
    "stats")
        # Outputs formatted stats for Web UI ingestion
        BAT_TEMP=$(awk '{print $1/10}' /sys/class/power_supply/battery/temp 2>/dev/null)
        RAM_USAGE=$(free | awk '/Mem:/ {printf "%.0f", $3/$2 * 100}')
        echo "TEMP:${BAT_TEMP:-N/A}|RAM:${RAM_USAGE:-0}"
        ;;
    *)
        echo "Usage: action.sh [boost|stats]"
        ;;
esac
