#!/bin/bash
#using shebang with -i to enable interactive mode (auto load .bashrc)
#this script was inspired from https://docs.travis-ci.com/user/languages/android/

set -e #stop immediately if any error happens

avd_name=$1

if [[ -z "$avd_name" ]]; then
  avd_name="avd28"
fi

#check if emulator work well
emulator -version

# create virtual device, default using Android 9 Pie image (API Level 28)
echo no | avdmanager create avd -n avd28 -k "system-images;android-28;google_apis;x86_64"

# start the emulator
emulator -avd avd28 -no-audio -no-window -no-accel &

# show connected virtual device
adb devices
