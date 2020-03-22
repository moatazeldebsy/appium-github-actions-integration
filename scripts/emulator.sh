#!/bin/bash

export ANDROID_HOME=$HOME/android
PATH=$PATH:$HOME/android/cmdline-tools/latest/bin
PATH=$PATH:$HOME/android/emulator
PATH=$PATH:$HOME/android/platform-tools

# Install to the Bash shell
touch $HOME/.bash_profile
echo "" >> $HOME/.bash_profile
echo "# Android development environment modifications" >> $HOME/.bash_profile
echo "source $HOME/android/paths.sh" >> $HOME/.bash_profile

# Install to Zsh
touch $HOME/.zshrc
echo "" >> $HOME/.zshrc
echo "# Android development environment modifications" >> $HOME/.zshrc
echo "source $HOME/android/paths.sh" >> $HOME/.zshrc

# Configuration
androidSdkVersion="29"

# Prerequisites
mkdir -p ~/.android
touch ~/.android/repositories.cfg

# Install the SDKs
(for run in {1..1000}; do echo y; done) >> yep.txt

cat ./yep.txt | sdkmanager --update
cat ./yep.txt | sdkmanager "platform-tools" "platforms;android-$androidSdkVersion" >> /dev/null
cat ./yep.txt | sdkmanager --licenses

rm ./yep.txt

# Configuration
androidSdkVersion="29"
deviceName="Device"
deviceProfile="pixel_xl" # See available profiles with: avdmanager list device
includePlayStore=false # See if SDK Version & Play Store are available together with: sdkmanager --list

# Obtain the AVD image
imageName=""

if ( $includePlayStore ); then
    imageName="system-images;android-$androidSdkVersion;google_apis_playstore;x86"
else
    imageName="system-images;android-$androidSdkVersion;google_apis;x86"
fi

(for run in {1..1000}; do echo y; done) >> yep.txt

cat ./yep.txt | sdkmanager $imageName >> /dev/null
cat ./yep.txt | sdkmanager --licenses

rm ./yep.txt

# Create the AVD
avdmanager create avd \
  --abi google_apis/x86 \
  --device "$deviceProfile" \
  --force \
  --name "$deviceName" \
  --package $imageName

# Configuration
deviceName="Device"
startEmulatorTimeout=180 # Number of seconds to wait for emulator boot before quitting

# Start the emulator
emulator -avd "$deviceName" -no-audio -wipe-data &

# Wait for the boot to finish
# Thanks: https://gist.github.com/mrk-han/db70c7ce2dfdc8ac3e8ae4bec823ba51
animationState=""
failCounter=0

until [[ "$animationState" =~ "stopped" ]]; do
    animationState=$(adb -e shell getprop init.svc.bootanim 2>&1 &) # Checks state of emulator while in the boot animation

    if [[ "$animationState" =~ "device not found" || "$animationState" =~ "device offline" || "$animationState" =~ "running" ]]; then
        ((failCounter += 1))
        echo "Waiting for emulator to start... $failCounter"
        echo "Boot Animation State: $animationState"

        if [[ ${failCounter} -gt ${startEmulatorTimeout} ]]; then
            echo "Timeout of $startEmulatorTimeout seconds reached; failed to start emulator"
            exit 1
        fi
    fi

    sleep 1
done

sleep 10 # Give time for the launcher to appear
echo "Emulator is ready!"

