#!/bin/bash

DIR="$HOME/Videos"
mkdir -p "$DIR"

FILE="$DIR/$(date +'%Y-%m-%d_%H-%M-%S').mp4"

wf-recorder -g "$(slurp)" -f "$FILE"
