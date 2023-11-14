
#!/bin/bash

unit_name="export.service"
log_file="myservicestatus.log"

# Get the current date and time
current_datetime=$(date +"%Y-%m-%d %H:%M:%S")

# Get the SUB status using systemctl show
sub_status=$(systemctl show "$unit_name" --property=SubState)

# Check if the SUB status is "exited" or "failed"
if [ "$sub_status" == "SubState=exited" ] || [ "$sub_status" == "SubState=failed" ]; then
    # Stop the service
    systemctl stop "$unit_name" >> "$log_file"

    # Disable the service
    systemctl disable "$unit_name" >> "$log_file"

    # Enable the service
    systemctl enable "$unit_name" >> "$log_file"

    # Start the service
    systemctl start "$unit_name" >> "$log_file"
    echo "[$current_datetime] Started the service $unit_name." >> "$log_file"
else
    echo "[$current_datetime] The service $unit_name is not in the exited or failed state. No action needed." >> "$log_file"
