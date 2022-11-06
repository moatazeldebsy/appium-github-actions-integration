#!/bin/bash
#using shebang with -i to enable interactive mode (auto load .bashrc)
#this script was inspired from https://docs.travis-ci.com/user/languages/android/

set -e #stop immediately if any error happens

echo $ANDROID_HOME
echo no | $ANDROID_HOME/tools/bin/avdmanager create avd -n avd30 -k "system-images;android-32;google_apis_playstore;arm64-v8a"

# start the emulator
$ANDROID_HOME/tools/bin/emulator -avd avd30 -no-audio -no-window -no-accel &

# show connected virtual device
adb devices
