#!/usr/bin/env sh

fvm flutter clean
fvm flutter pub get
cd ios/
pod install
cd ..
