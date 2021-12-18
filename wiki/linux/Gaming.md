## Steam

Run winecfg for a game, to enable cursor capturing

```sh
PROTON_VERSION="Proton - Experimental"
GAME_ID=1184370
PROTON_DIR=~/.local/share/Steam/steamapps/common
GAMEPFX_DIR="$HOME/.steam/steam/steamapps/compatdata/$GAME_ID/pfx/"
export WINEPREFIX="$GAMEPFX_DIR" WINEARCH=win64
"$PROTON_DIR/$PROTON_VERSION/files/bin/wine64" 'winecfg.exe'
```

To get the game id

```sh
grep -i <GAME NAME> ~/.local/share/Steam/steamapps/appmanifest_*.acf
```

