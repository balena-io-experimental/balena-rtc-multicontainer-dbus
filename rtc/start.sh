#!/bin/bash

## Trigger loading system time from RTC
# https://www.freedesktop.org/wiki/Software/systemd/timedated/
function call_time() {
    local_rtc=$1
    fix_system=$2
    DBUS_SYSTEM_BUS_ADDRESS=unix:path=/host/run/dbus/system_bus_socket \
     dbus-send \
      --system \
      --print-reply \
      --reply-timeout=2000 \
      --type=method_call \
      --dest=org.freedesktop.timedate1  \
      /org/freedesktop/timedate1  \
      org.freedesktop.timedate1.SetLocalRTC \
      boolean:${local_rtc} boolean:${fix_system} boolean:false
}
# This call will "fail" due to read-only file system, but we need it for the next step
call_time true false
# This call will trigger RTC->system time update
call_time false true

# Do the main work, whatever it may be...
# Or don't do anything, and do the work in other services
while : ; do date; sleep "${INTERVAL:-15}"; done
