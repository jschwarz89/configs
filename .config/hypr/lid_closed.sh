#!/bin/bash

if [ "$(acpi -a)" == "Adapter 0: on-line" ]
then
	hyprctl keyword monitor "eDP-1, disable"
else
	hyprlock & disown
	systemctl suspend
fi