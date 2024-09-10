# HOW TO USE EVENT SCRIPTS

## Install acpid service

- yay -S acpid

## Enable and start service

- sudo systemctl enable acpid
- sudo systemctl start acpid

## Verify service status

- sudo systemctl status acpid

## Copy script to acpi folder

- cp ./SCRIPT_NAME /etc/acpi/

### Example

- cp ./lid_monitor_behavior /etc/acpi/lid.sh

## Add execution permissions

- sudo chmod +x /etc/acpi/lid.sh

## Add event to acpi's event stack

### Create and edit event file

- nvim /etc/acpi/events/lid

## Add event file content

- event=button/lid.\* (This will listen lid events)
- action=/etc/acpi/lid.sh (This will execute script on event action)

## Restart acpid service

- sudo systemctl restart acpid
