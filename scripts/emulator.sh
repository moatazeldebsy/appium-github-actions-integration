#!/usr/bin/env bash
# fail if any commands fails
set -e
# debug log
#set -x

cd $ANDROID_HOME/emulator

echo no | avdmanager create avd -n Nexus_5X_API_26 -k "system-images;android-26;google_apis;x86" --force

emulator -avd Nexus_5X_API_26 -no-window -no-audio -debug-init > /dev/null 2>&1 &

echo "Waiting emulator is ready..."

adb wait-for-device shell 'while [[ -z $(getprop sys.boot_completed) ]]; do sleep 1; done; input keyevent 82'

echo "Emulator is ready!"
