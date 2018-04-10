#!/bin/bash

# Trigger loading system time from RTC
# https://www.freedesktop.org/wiki/Software/systemd/timedated/
# (the boolean:true below triggers that)
DBUS_SYSTEM_BUS_ADDRESS=unix:path=/host/run/dbus/system_bus_socket \
 dbus-send \
  --system \
  --print-reply \
  --reply-timeout=2000 \
  --type=method_call \
  --dest=org.freedesktop.timedate1  \
  /org/freedesktop/timedate1  \
  org.freedesktop.timedate1.SetLocalRTC \
  boolean:false boolean:true boolean:false

# Do the main work, whatever it may be...
# Or don't do anything, and do the work in other services
while : ; do date; sleep "${INTERVAL:-15}"; done
