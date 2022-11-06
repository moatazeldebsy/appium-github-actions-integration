#!/bin/bash
#using shebang with -i to enable interactive mode (auto load .bashrc)
#this script was inspired from https://docs.travis-ci.com/user/languages/android/

set -e #stop immediately if any error happens

sudo $ANDROID_HOME/tools/bin/sdkmanager --update
$ANDROID_HOME/tools/bin/sdkmanager --install "emulator"
$ANDROID_HOME/tools/bin/sdkmanager --install "system-images;android-29;google_apis;x86"
echo "no" | $ANDROID_HOME/tools/bin/avdmanager --verbose create avd --force --name "pixel" --device "pixel" --package "system-images;android-29;google_apis;x86" --tag "google_apis" --abi "x86"
$ANDROID_HOME/emulator/emulator-headless @pixel -no-boot-anim -netdelay none -no-snapshot -wipe-data -verbose -show-kernel -no-audio -gpu swiftshader_indirect -no-snapshot &> /tmp/log.txt &
sleep 160

#echo no | $ANDROID_HOME/tools/bin/avdmanager create avd -n avd30 -k "system-images;android-32;google_apis_playstore;arm64-v8a"

# start the emulator
#$ANDROID_HOME/tools/bin/emulator -avd avd30 -no-audio -no-window -no-accel &

# show connected virtual device
adb devices


