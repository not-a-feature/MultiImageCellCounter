# Multi Image Cell Counter (MICC)
MICC is a simple [ImageJ](https://imagej.nih.gov/ij/) - Macro to count cells of multiple images at once.

## Requirements
- ImageJ 1 (may also work on ImageJ 2)

## Installation
- Download the MultiImageCellCounter.ijm (or download the whole project)
- No installation is required.

## Usage
- Click on `Plugins -> Macros -> Run...`
- Set the desired parameters
- Click on ok

<img src="https://user-images.githubusercontent.com/25013642/118493473-71718180-b721-11eb-88eb-4fe40982f7c5.png" width="400" alt="screenshot">

## Parameters
### Path to folder
- Path to the folder containg the images.
- Please make sure only images are inside this folder.

### Minimum cell size
- Minimum cell size.
- The higher, the less artifacts are detected

### Minimum cell size
- Maximum cell size.
- Set to 0 if no maximum cell size is desired.

### Minimum / Maximum cell circularity
- Roundness of cell

### Fill holes
- Fill the holes of the generated mask. This setting should not have a major impact.

### Watershed
- Watersheds image. 
- Only turn off if the cells are very scattered.

### Exclude on edges
- Excludes cells located at the edge of the image

### Channel
- Select channel of image.
  - Open one of the image-files.
  - If several windows are opening close every window except the desired one.
  - Take a look at the title. E.g.: "123-Alexa555.zvi Ch0"
  - The last number is the channel.
- Set to -1 if the image has only one channel.

### Output files directory
- If this is set, this programm will save the processed (counted) images to this folder.

## License
```
Copyright (C) 2021 by Jules Kreuer - @not_a_feature
This piece of software is published unter the GNU General Public License v3.0
TLDR:

| Permissions      | Conditions                   | Limitations |
| ---------------- | ---------------------------- | ----------- |
| ✓ Commercial use | Disclose source              | ✕ Liability |
| ✓ Distribution   | License and copyright notice | ✕ Warranty  |
| ✓ Modification   | Same license                 |             |
| ✓ Patent use     | State changes                |             |
| ✓ Private use    |                              |             |
```
Go to https://github.com/not-a-feature/MultiImageCellCounter/blob/main/LICENSE to see the full version.
