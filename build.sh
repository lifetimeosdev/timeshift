#!/usr/bin/env bash

set -exo pipefail

sudo apt install valac libgtk-3-dev libjson-glib-dev \
	libvte-2.91-dev libgee-0.8-dev libxapp-dev \
	help2man meson

meson setup build

pushd ./build

meson compile

popd

cp ./build/src/timeshift .
cp ./build/src/timeshift-gtk .
