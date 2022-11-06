#!/bin/bash
#using shebang with -i to enable interactive mode (auto load .bashrc)

set -e #stop immediately if any error happens

# Install Android Image version 28
yes | sdkmanager "platform-tools" "platforms;android-28" "emulator"
yes | sdkmanager "system-images;android-28;google_apis;x86_64"
emulator -version

echo "INSTALL ANDROID SDK DONE!"
