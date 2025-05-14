#!/usr/bin/env bash

sketchybar -m --set ram_label label=$(memory_pressure | grep "System-wide memory free percentage:" | awk '{ printf("%02.0f\n", 100-$5"%") }')%
