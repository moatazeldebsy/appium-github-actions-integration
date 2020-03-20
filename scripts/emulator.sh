#!/usr/bin/env bash
# fail if any commands fails 
set -e
# debug log
set -x

cd $ANDROID_HOME/emulator

echo no | avdmanager create avd -n $ANDROID_EMULATOR_NAME -k "system-images;android-28;google_apis;x86" --force

./emulator-headless -no-window -gpu swiftshader_indirect -no-audio -no-boot-anim -camera-back none @testEmulator > /dev/null 2>&1 &

echo "Waiting emulator is ready..."
adb wait-for-device shell 'while [[ -z $(getprop sys.boot_completed) ]]; do sleep 1; done; input keyevent 82'
echo "Emulator is ready!"
