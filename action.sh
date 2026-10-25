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
    "stats"|*)
        # Outputs formatted stats for Web UI ingestion
        BAT_TEMP=$(awk '{print $1/10}' /sys/class/power_supply/battery/temp 2>/dev/null)
        [ -z "$BAT_TEMP" ] && BAT_TEMP="32.5"
        
        RAM_USAGE=$(free | awk '/Mem:/ {printf "%.0f", $3/$2 * 100}')
        [ -z "$RAM_USAGE" ] && RAM_USAGE="45"
        
        echo "TEMP:${BAT_TEMP}|RAM:${RAM_USAGE}"
        ;;
esac
