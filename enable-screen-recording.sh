#!/bin/bash

# Enable screen recording for TeamViewer on macOS

# Get the current user's username
CURRENT_USER=$(stat -f "%Su" /dev/console)

# Add the user to the "accessibility" group to enable screen recording
sudo dseditgroup -o edit -a $CURRENT_USER -t user access_bpf

# Add the user to the "developer" group to enable screen recording
sudo dseditgroup -o edit -a $CURRENT_USER -t user _developer

# Grant permissions to TeamViewer for screen recording
tccutil reset ScreenCapture com.teamviewer.teamviewer

echo "Screen recording has been enabled for TeamViewer."