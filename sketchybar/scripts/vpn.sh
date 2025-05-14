#!/bin/sh

VPN=$(scutil --nc list | grep Connected | sed -E 's/.*"(.*)".*/\1/')

if [[ $VPN != "" ]]; then
  sketchybar -m --set vpn drawing=on
else
  sketchybar -m --set vpn drawing=off
fi
