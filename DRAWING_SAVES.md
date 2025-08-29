# Drawing Save Feature

This feature allows Scribble.rs to automatically save drawings as PNG images when rounds end.

## Configuration

Add this environment variable to enable drawing saves:

```bash
SAVE_DRAWINGS=true
```

Or add it to your `.env` file:

```
SAVE_DRAWINGS=true
```

## File Structure

Drawings are saved in the following structure:

```
drawings/
├── room-id-1/
│   ├── round_1_cat_2024-01-15_14-30-25.png
│   ├── round_2_dog_2024-01-15_14-35-10.png
│   └── round_3_house_2024-01-15_14-40-45.png
├── room-id-2/
│   ├── round_1_tree_2024-01-15_15-00-12.png
│   └── round_2_car_2024-01-15_15-05-30.png
└── ...
```

Each drawing file is named with:
- `round_X` - The round number
- `word` - The word that was being drawn
- `timestamp` - When the drawing was saved

## Downloading Drawings

### Linux/Mac

Use the provided script:

```bash
# Make script executable
chmod +x scripts/download_drawings.sh

# Download all drawings
./scripts/download_drawings.sh

# Download drawings from specific room
./scripts/download_drawings.sh room-id-123

# Download to custom folder
./scripts/download_drawings.sh all ./my_drawings
```

### Windows

Use the batch script:

```cmd
# Download all drawings
scripts\download_drawings.bat

# Download drawings from specific room
scripts\download_drawings.bat room-id-123

# Download to custom folder
scripts\download_drawings.bat all my_drawings
```

### Manual Download

You can also manually copy the drawings folder:

```bash
# Copy all drawings
cp -r drawings/ ./downloaded_drawings/

# Copy specific room
cp -r drawings/room-id-123/ ./downloaded_drawings/
```

## Technical Details

- Drawings are rendered as 1600x900 PNG images (matching the game canvas)
- Colors match the game's color palette exactly
- Line thickness and fill operations are preserved
- Images are saved when rounds end (before the drawing is cleared)
- Failed saves are logged but don't interrupt gameplay

## Storage Considerations

- Each PNG file is typically 50-200KB depending on drawing complexity
- A busy server might generate hundreds of images per day
- Consider implementing cleanup policies for old drawings
- Monitor disk space usage in production

## Troubleshooting

If drawings aren't being saved:

1. Check that `SAVE_DRAWINGS=true` is set
2. Verify the server has write permissions to create the `drawings/` folder
3. Check server logs for any error messages about saving drawings
4. Ensure sufficient disk space is available

## Future Enhancements

Possible improvements:
- Configurable image format (JPEG, WebP)
- Automatic cleanup of old drawings
- Compression options
- Export to cloud storage
- Drawing replay functionality