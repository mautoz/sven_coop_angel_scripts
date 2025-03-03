# Sven Coop Angelscripts

A simple repository with some AngelScript scripts for Sven Co-op.

## How to Use
Sven Co-op is usually installed in:
```
C:\Program Files (x86)\Steam\steamapps\common\Sven Co-op\
```
Maps can be found in either the svencoop or svencoop_downloads folder. Both contain subfolders named maps and scripts.

## Steps to Use a Script

0. Save your AngelScript (.as) file in the scripts/maps folder. Example:
```
[scripts/maps/secretlab_r_custom_script.as](secretlab_r/scripts/maps/secretlab_r_custom_script.as)
```
1. Create a .cfg file in the maps folder and add your script reference:
```
map_script secretlab_r_custom_script
```
Note: The .cfg file must have the same name as the map's .bsp file and be in the same directory.

2. [OPTIONAL] Add a Message of the Day (MOTD) by including this in the .cfg file:
```
motdfile "maps/secretlab_r_motd.txt"
```
The file secretlab_r_motd.txt should be in the same folder as the map's .bsp file.
