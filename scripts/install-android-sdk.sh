#!/bin/bash
#using shebang with -i to enable interactive mode (auto load .bashrc)

set -e #stop immediately if any error happens

sudo apt update
sudo apt install default-jre
sudo apt install default-jdk


java -version
javac -version

sudo apt update

# Install SDK Manager
sudo apt-get install android-sdk

cd ~ && wget https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip

ANDROID_HOME=/opt/androidsdk
mkdir -p $ANDROID_HOME
sudo apt install unzip -y && unzip sdk-tools-linux-4333796.zip -d $ANDROID_HOME

echo "export ANDROID_HOME=$ANDROID_HOME" >> ~/.bashrc
echo 'export SDK=$ANDROID_HOME' >> ~/.bashrc
echo 'export PATH=$SDK/emulator:$SDK/tools:$SDK/tools/bin:$SDK/platform-tools:$PATH' >> ~/.bashrc
source ~/.bashrc

# Install Android Image version 28
yes | sdkmanager "platform-tools" "platforms;android-28" "emulator"
yes | sdkmanager "system-images;android-28;google_apis;x86_64"
emulator -version

echo "INSTALL ANDROID SDK DONE!"
