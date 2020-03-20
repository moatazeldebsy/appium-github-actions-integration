#!/usr/bin/env bash

set -eu

# start android emulator
START=`date +%s` > /dev/null

echo no | $ANDROID_HOME/tools/android create avd --force -n test --abi efault/armeabi-v7a -k 'system-images;android-25;google_apis;x86'
$ANDROID_HOME/tools/android list avd
$ANDROID_HOME/tools/emulator64-arm -avd test -no-window -no-boot-anim -no-audio -verbose &

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
