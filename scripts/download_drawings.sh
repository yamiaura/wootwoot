#!/bin/bash

# Script to download drawings from a Scribble.rs server
# Usage: ./download_drawings.sh [room_id] [destination_folder]

ROOM_ID=${1:-"all"}
DEST_FOLDER=${2:-"./downloaded_drawings"}

echo "Downloading drawings..."
echo "Room ID: $ROOM_ID"
echo "Destination: $DEST_FOLDER"

# Create destination folder
mkdir -p "$DEST_FOLDER"

if [ "$ROOM_ID" = "all" ]; then
    echo "Downloading all room drawings..."
    # Copy all drawings
    if [ -d "drawings" ]; then
        cp -r drawings/* "$DEST_FOLDER/"
        echo "All drawings downloaded to $DEST_FOLDER"
    else
        echo "No drawings folder found. Make sure the server has saved some drawings."
    fi
else
    echo "Downloading drawings for room: $ROOM_ID"
    # Copy specific room drawings
    if [ -d "drawings/$ROOM_ID" ]; then
        cp -r "drawings/$ROOM_ID" "$DEST_FOLDER/"
        echo "Room $ROOM_ID drawings downloaded to $DEST_FOLDER/$ROOM_ID"
    else
        echo "No drawings found for room $ROOM_ID"
    fi
fi

# List downloaded files
echo ""
echo "Downloaded files:"
find "$DEST_FOLDER" -name "*.png" -type f | head -20
total_files=$(find "$DEST_FOLDER" -name "*.png" -type f | wc -l)
echo "Total PNG files: $total_files"