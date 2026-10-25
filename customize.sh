#!/system/bin/sh
SKIPUNZIP=0

ui_print "--------------------------------------"
ui_print " Installing Turbo Performance Boost v2.0 "
ui_print "--------------------------------------"

# Set permissions for execution scripts
set_perm "$MODPATH/service.sh" 0 0 0755
set_perm "$MODPATH/action.sh" 0 0 0755

# Ensure webroot folder has correct readable permissions
set_perm_recursive "$MODPATH/webroot" 0 0 0755 0644

ui_print "[+] Permissions configured successfully."
ui_print "[+] Web UI Dashboard installed."
ui_print "[+] Installation complete! Enjoy gaming!"
