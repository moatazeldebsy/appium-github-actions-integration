#!/bin/bash

set -eu
# start android emulator
cd $ANDROID_HOME/tools/bin
echo no | avdmanager create avd -n Android26 -k 'system-images;android-23;google_apis;armeabi-v7a'
avdmanager list avd
cd ..
emulator -avd test -no-window -no-boot-anim -no-audio -verbose &

bootanim=""
failcounter=0
timeout_in_sec=360

until [[ "$bootanim" =~ "stopped" ]]; do
  bootanim=`adb -e shell getprop init.svc.bootanim 2>&1 &`
  if [[ "$bootanim" =~ "device not found" || "$bootanim" =~ "device offline"
    || "$bootanim" =~ "running" ]]; then
    let "failcounter += 1"
    echo "Waiting for emulator to start"
    if [[ $failcounter -gt timeout_in_sec ]]; then
      echo "Timeout ($timeout_in_sec seconds) reached; failed to start emulator"
      exit 1
    fi
  fi
  sleep 1
done

echo "Emulator is ready"
# Unlock the Lock Screen
$ANDROID_HOME/platform-tools/adb shell input keyevent 82 &
$ANDROID_HOME/platform-tools/adb shell input keyevent 4 &
DURATION=$(( `date +%s` - START )) > /dev/null
echo "Android Emulator started after $DURATION seconds."

# emulator isn't ready yet, wait 1 min more
# prevents APK installation error
sleep 60
