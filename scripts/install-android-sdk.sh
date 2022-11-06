#!/bin/bash
#using shebang with -i to enable interactive mode (auto load .bashrc)

set -e #stop immediately if any error happens

# Install Open SDK
sudo apt update
sudo apt-get install openjdk-11-jdk -y
sudo apt-get install android-sdk

java -version

ls -l ~/Downloads
sudo mkdir ~/DevTools
sudo mkdir ~/DevTools/Android
sudo mkdir ~/DevTools/Android/cmdline-tools

wget commandlinetools-linux-8512546_latest.zip
unzip commandlinetools-linux-8512546_latest.zip

mv tools ~/DevTools/Android/cmdline-tools/
ls -l ~/DevTools/Android/cmdline-tools/tools
sudo nano ~/.bashrc

echo DEV_TOOLS="/home/$USER/DevTools"
echo JAVA_HOME="$DEV_TOOLS/JDK/jdk-11.0.7+10"
echo ANDROID_HOME="$DEV_TOOLS/Android"
echo export JAVA_HOME
echo export ANDROID_HOME
echo PATH="$JAVA_HOME/bin:$ANDROID_HOME/cmdline-tools/tools/bin:$ANDROID_HOME/platform-tools:$PATH"

source ~/.bashrc
sdkmanager --version

sdkmanager --list
sdkmanager "platform-tools" "platforms;android-29"
sdkmanager "build-tools" "build-tools;29.0.3"

yes | sdkmanager --licenses
sdkmanager --update

echo "INSTALL ANDROID SDK DONE!"
