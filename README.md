# docker-valheim-ghost
add goldberg emu to `mbround18/valheim-docker`

## sample compose
look at `ghostserverd/mediaserver-docker` for information about where `${CONFIG_DIR}`, `${PUID}`, `${PGID}`, `${TIMEZONE}` come from

```
version: "3"

services:
  valheim:
    image: ghostserverd/valheim
    container_name: valheim
    #ports:
    #  - 2456:2456/udp
    #  - 2457:2457/udp
    #  - 2458:2458/udp
    #  - 47584:47584
    network_mode: host
    environment:
      - PUID=${PUID}
      - PGID=${PGID}
      - TZ=${TIMEZONE}
      - PORT=2456
      - NAME=yourname
      - WORLD=yourworld
      - PASSWORD=somepassword
      - PUBLIC=1
      - AUTO_UPDATE=0
      # this is required
      - XDG_DATA_HOME=/home/steam/
    volumes:
      # these are all required
      - ${CONFIG_DIR}/valheim/saves:/home/steam/.config/unity3d/IronGate/Valheim
      - ${CONFIG_DIR}/valheim/server:/home/steam/valheim
      - ${CONFIG_DIR}/valheim/backups:/home/steam/backups
```

## server setup
1. Port forward `47584,2456,2457,2458` to the machine that will host the server.
2. Run `docker-compose -f valheim.yml up valheim`.
3. The first time you run it, it will probably hang with a log message like `DungeonDB Start <some_number>`. Once it reaches this point, kill the container and start it again. This time, it should complete successfully and you will be able to connect in the future. Even if it does reach the `Game server connected` message, you need to kill it to ensure that the emu is set up correctly.

## client setup
courtesy of mingo222

These steps assume the Goldberg Emu has been properly installed (use google). Apply the version in the "experimental" folder (since it has the nice Shift-Tab overlay). I also advise my friends to update the files `account_name.txt` and `user_steam_id.txt` at `%appdata%\Goldberg SteamEmu Saves\settings` after running the game once, to avoid any username/ID conflict issues.

1. For all players, a file called `disable_lan_only.txt` must be created beside the Goldberg Emu `steam_api64.dll` (so, for Valheim, at `valheim_Data\Plugins\x86_64`). It can be left empty.
2. Whoever is hosting the world will need to forward the right port, usually `47584` unless `listen_port.txt` has been changed (`listen_port.txt` must be the same for all users).
3. Whoever is connecting to the host outside of the LAN will need to create a folder called `steam_settings` beside `steam_api64.dll` (same directory as `disable_lan_only.txt`). Inside this folder, a file called `custom_broadcasts.txt` must be created. The public IP address or domain of the host must be placed inside of this file.
