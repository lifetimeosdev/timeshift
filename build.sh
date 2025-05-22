#!/usr/bin/env bash

set -exo pipefail

read -p "Install dependencies? (y/n): " choice

if [[ "$choice" == "y" ]]; then
	sudo apt install valac libgtk-3-dev libjson-glib-dev \
		libvte-2.91-dev libgee-0.8-dev libxapp-dev \
		help2man meson
fi


meson setup build

pushd ./build

meson compile

popd

cp ./build/src/timeshift .
cp ./build/src/timeshift-gtk .
strip ./timeshift
strip ./timeshift-gtk


read -p "Replace system binary? (y/n): " choice

if [[ "$choice" == "y" ]]; then
	# Only first time to backup or orignial file will be overwritten.
	if ! test -f /usr/bin/timeshift.bak; then
		sudo cp /usr/bin/timeshift /usr/bin/timeshift.bak
	fi
	if ! test -f /usr/bin/timeshift-gtk.bak; then
		sudo cp /usr/bin/timeshift-gtk /usr/bin/timeshift-gtk.bak
	fi

	sudo cp ./timeshift /usr/bin/timeshift
	sudo cp ./timeshift-gtk /usr/bin/timeshift-gtk
fi
