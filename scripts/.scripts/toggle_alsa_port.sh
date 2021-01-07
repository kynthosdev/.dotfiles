#!/usr/bin/env bash

DEVICE=$(pactl list sinks | grep "Name" | cut -d ':' -f 2)
SINK_ACTIVE_PORT=$(pactl list sinks | grep "Active Port" | awk '{ print $3,$4 }')

SPEAKER="[Out] Speaker"
HEADPHONES="[Out] Headphones"

if [[ "$SINK_ACTIVE_PORT" == "$SPEAKER" ]]; then
    SINK_ACTIVE_PORT=$HEADPHONES
else [[ "$SINK_ACTIVE_PORT" == "$HEADPHONES" ]]
    SINK_ACTIVE_PORT=$SPEAKER
fi

# echo $SINK_ACTIVE_PORT
# echo $DEVICE
# echo $DEVICE "$SINK_ACTIVE_PORT"

pactl set-sink-port $DEVICE "$SINK_ACTIVE_PORT"
