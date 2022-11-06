#!/bin/bash
#using shebang with -i to enable interactive mode (auto load .bashrc)
#this script was inspired from https://docs.travis-ci.com/user/languages/android/

set -e #stop immediately if any error happens

# create virtual device, default using Android 10 Pie image (API Level 29)
echo $ANDROID_HOME
echo no | $ANDROID_HOME/tools/bin/avdmanager create avd -n avd29 -k "system-images;android-29;google_apis;x86_64"

# start the emulator
tools/bin/emulator -avd avd29 -no-audio -no-window -no-accel &

# show connected virtual device
adb devices
