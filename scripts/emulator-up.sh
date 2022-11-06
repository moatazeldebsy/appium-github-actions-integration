#!/bin/bash
#using shebang with -i to enable interactive mode (auto load .bashrc)
#this script was inspired from https://docs.travis-ci.com/user/languages/android/

set -e #stop immediately if any error happens

echo $ANDROID_HOME
echo no | $ANDROID_HOME/tools/bin/avdmanager create avd -n avd30 -k "system-images;android-30;google_apis;x86"

# start the emulator
$ANDROID_HOME/tools/bin/emulator -avd avd30 -no-audio -no-window -no-accel &

# show connected virtual device
adb devices
