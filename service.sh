# ==========================================
# 1. SURFACEFLINGER & RENDERING OPTIMIZATIONS
# ==========================================
setprop debug.sf.hw 1
setprop debug.sf.early_app_phase_offset_ns -24000000
setprop debug.sf.early_gl_phase_offset_ns -30000000
setprop debug.sf.early_gl_app_phase_offset_ns -15000000
setprop debug.sf.early_phase_offset_ns -24000000
setprop debug.sf.high_refresh_rate_matching 1
setprop debug.sf.layer_caching_active_deactivation_ns 1

# ==========================================
# 2. VULKAN & GRAPHICS PIPELINE BOOST
# ==========================================
setprop debug.vulkan.async_compute 1
setprop debug.vulkan.frame_pacing 1
setprop debug.vulkan.multi_thread 1
setprop debug.vulkan.pipeline_cache 1
setprop debug.vulkan.precompile_shaders 1
setprop debug.vulkan.enable_extension_vsync 0
setprop debug.hwui.renderer skia_vk
setprop debug.hwui.use_hint_manager 1

# ==========================================
# 3. HARDWARE ACCELERATION & UI FLUIDITY
# ==========================================
setprop video.accelerate.hw 1
setprop debug.performance.tuning 1
setprop debug.hwui.target_fps 120
setprop persist.sys.ui.hw 1

# ==========================================
# 4. TOUCH RESPONSIVENESS & INPUT BOOST
# ==========================================
setprop debug.touch.boost 1
setprop ro.min.fling_velocity 16000
setprop ro.max.fling_velocity 32000

# ==========================================
# 5. NETWORKING & PING STABILIZATION (GAMING)
# ==========================================
setprop net.tcp.buffersize.default 4096,87380,704200,4096,16384,110208
setprop net.tcp.buffersize.wifi 524288,1048576,2097152,262144,524288,1048576

