# AMD - Automated Music Downloader 
[![Docker Build](https://img.shields.io/docker/cloud/automated/randomninjaatk/amd?style=flat-square)](https://hub.docker.com/r/randomninjaatk/amd)
[![Docker Pulls](https://img.shields.io/docker/pulls/randomninjaatk/amd?style=flat-square)](https://hub.docker.com/r/randomninjaatk/amd)
[![Docker Stars](https://img.shields.io/docker/stars/randomninjaatk/amd?style=flat-square)](https://hub.docker.com/r/randomninjaatk/amd)
[![Docker Hub](https://img.shields.io/badge/Open%20On-DockerHub-blue?style=flat-square)](https://hub.docker.com/r/randomninjaatk/amd)
[![Discord](https://img.shields.io/discord/747100476775858276.svg?style=flat-square&label=Discord&logo=discord)](https://discord.gg/JumQXDc "realtime support / chat with the community." )

[RandomNinjaAtk/amd](https://github.com/RandomNinjaAtk/docker-amd) is a Lidarr companion script to automatically download music for Lidarr 

[![RandomNinjaAtk/amd](https://raw.githubusercontent.com/RandomNinjaAtk/unraid-templates/master/randomninjaatk/img/amd.png)](https://github.com/RandomNinjaAtk/docker-amd)

### Audio ([AMD](https://github.com/RandomNinjaAtk/docker-amd)) + Video ([AMVD](https://github.com/RandomNinjaAtk/docker-amvd)) (Plex Example)
![](https://raw.githubusercontent.com/RandomNinjaAtk/Scripts/master/images/plex-musicvideos.png)

## Features
* Downloading **Music** using online sources for use in popular applications (Plex/Kodi/Emby/Jellyfin): 
  * Searches for downloads based on Lidarr's album wanted list
  * Downloads using a third party download client automatically
  * FLAC / MP3 (320/120) Download Quality
  * Notifies Lidarr to automatically import downloaded files
  * Music is properly tagged and includes coverart before Lidarr Receives them (Third Party Download Client handles it)

## Supported Architectures

The architectures supported by this image are:

| Architecture | Tag |
| :----: | --- |
| x86-64 | latest |

## Version Tags

| Tag | Description |
| :----: | --- |
| latest | Newest release code |


## Parameters

Container images are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate `<external>:<internal>` respectively. For example, `-p 8080:80` would expose port `80` from inside the container to be accessible from the host's IP on port `8080` outside the container. See the [wiki](https://github.com/RandomNinjaAtk/docker-amd/wiki) to understand how it works.

| Parameter | Function |
| --- | --- |
| `-v /config` | Configuration files for Lidarr. |
| `-v /downloads-amd` | Path to your download folder location. (This should match what you have in DOWNLOADS) |
| `-e PUID=1000` | for UserID - see below for explanation |
| `-e PGID=1000` | for GroupID - see below for explanation |
| `-e DOWNLOADS=/downloads-amd` | for GroupID - see below for explanation |
| `-e AUTOSTART=true` | true = Enabled :: Runs script automatically on startup |
| `-e SCRIPTINTERVAL=1h` | #s or #m or #h or #d :: s = seconds, m = minutes, h = hours, d = days :: Amount of time between each script run, when AUTOSTART is enabled|
| `-e DOWNLOADMODE=wanted` | wanted or artist :: wanted mode only download missing/cutoff :: artist mode downloads all albums by an artist (requires lidarr volume mapping root media folders for import) |
| `-e LIST=both` | both or missing or cutoff :: both = missing + cutoff :: missng = lidarr missing list :: cutoff = lidarr cutoff list |
| `-e SEARCHTYPE=both` | both or artist or fuzzy :: both = artist + fuzzy searching :: artist = only artist searching :: fuzzy = only fuzzy searching (Various Artist is always fuzzy searched, regardless of setting) |
| `-e CONCURRENCY=1` | Number of concurrent downloads |
| `-e FORMAT=FLAC` | FLAC or MP3 or OPUS or AAC or ALAC |
| `-e BITRATE=320` | FLAC -> OPUS/AAC/MP3 will be converted using this bitrate  (MP3 320/128 is native, not converted) |
| `-e REQUIREQUALITY=false` | true = enabled :: Requires all downloaded files match target file extension (mp3 or flac) when enabled |
| `-e MATCHDISTANCE=10` | Set as an integer, the higher the number, the more lienet it is. Example: A match score of 0 is a perfect match :: For more information, this score is produced using this function: [Algorithm Implementation/Strings/Levenshtein distance](https://en.wikibooks.org/wiki/Algorithm_Implementation/Strings/Levenshtein_distance) |
| `-e REPLAYGAIN=true` | true = enabled :: Scans and analyzes files to add replaygain tags to song metadata |
| `-e FOLDERPERMISSIONS=766` | Based on chmod linux permissions |
| `-e FILEPERMISSIONS=666` | Based on chmod linux permissions |
| `-e MBRAINZMIRROR=https://musicbrainz.org` | OPTIONAL :: Only change if using a different mirror |
| `-e MBRATELIMIT=1` | OPTIONAL: musicbrainz rate limit, musicbrainz allows only 1 connection per second, max setting is 10 :: Set to 101 to disable limit |
| `-e LIDARRURL=http://x.x.x.x:8686` | Set domain or IP to your Lidarr instance including port. If using reverse proxy, do not use a trailing slash. Ensure you specify http/s. |
| `-e LIDARRAPIKEY=LIDARRAPI` | Lidarr API key. |
| `-e ARL_TOKEN=ARLTOKEN` | User token for dl client, for instructions to obtain token: https://notabug.org/RemixDevs/DeezloaderRemix/wiki/Login+via+userToken |
| `-e NOTIFYPLEX=false` | true = enabled :: ONLY APPLIES ARTIST MODE :: Plex must have a music library added and be configured to use the exact same mount point as Lidarr's root folder |
| `-e PLEXLIBRARYNAME=Music` | This must exactly match the name of the Plex Library that contains the Lidarr Media Folder data |
| `-e PLEXURL=http://x.x.x.x:32400` | ONLY used if NOTIFYPLEX is enabled... |
| `-e PLEXTOKEN=plextoken` | ONLY used if NOTIFYPLEX is enabled... |

## Usage

Here are some example snippets to help you get started creating a container.

### docker

```
docker create \
  --name=amd \
  -v /path/to/config/files:/config \
  -v /path/to/downloads:/downloads-amd \
  -e PUID=1000 \
  -e PGID=1000 \
  -e DOWNLOADS=/downloads-amd \
  -e AUTOSTART=true \
  -e SCRIPTINTERVAL=1h \
  -e DOWNLOADMODE=wanted \
  -e LIST=both \
  -e SEARCHTYPE=both \
  -e CONCURRENCY=1 \
  -e FORMAT=FLAC \
  -e BITRATE=320 \
  -e REQUIREQUALITY=false \
  -e MATCHDISTANCE=10 \
  -e REPLAYGAIN=true \
  -e FOLDERPERMISSIONS=766 \
  -e FILEPERMISSIONS=666 \
  -e MBRAINZMIRROR=https://musicbrainz.org \
  -e MBRATELIMIT=1 \
  -e LIDARRURL=http://x.x.x.x:8686 \
  -e LIDARRAPIKEY=LIDARRAPI \
  -e ARL_TOKEN=ARLTOKEN	\
  -e NOTIFYPLEX=false \
  -e PLEXLIBRARYNAME=Music \
  -e PLEXURL=http://x.x.x.x:8686 \
  -e PLEXTOKEN=plextoken \
  --restart unless-stopped \
  randomninjaatk/amd 
```


### docker-compose

Compatible with docker-compose v2 schemas.

```
version: "2.1"
services:
  amd:
    image: randomninjaatk/amd 
    container_name: amd
    volumes:
      - /path/to/config/files:/config
      - /path/to/downloads:/downloads-amd
    environment:
      - PUID=1000
      - PGID=1000
      - DOWNLOADS=/downloads-amd
      - AUTOSTART=true
      - SCRIPTINTERVAL=1h
      - DOWNLOADMODE=wanted
      - LIST=both
      - SEARCHTYPE=both
      - CONCURRENCY=1
      - FORMAT=FLAC
      - BITRATE=320
      - REQUIREQUALITY=false
      - MATCHDISTANCE=10
      - REPLAYGAIN=true
      - FOLDERPERMISSIONS=766
      - FILEPERMISSIONS=666
      - MBRAINZMIRROR=https://musicbrainz.org
      - MBRATELIMIT=1
      - LIDARRURL=http://x.x.x.x:8686
      - LIDARRAPIKEY=LIDARRAPI
      - ARL_TOKEN=ARLTOKEN
      - NOTIFYPLEX=false
      - PLEXLIBRARYNAME=Music
      - PLEXURL=http://x.x.x.x:8686
      - PLEXTOKEN=plextoken
    restart: unless-stopped
```


# Script Information
* Script will automatically run when enabled, if disabled, you will need to manually execute with the following command:
  * From Host CLI: `docker exec -it amd /bin/bash -c 'bash /config/scripts/download.bash'`
  * From Docker CLI: `bash /config/scripts/download.bash`
  
## Directories:
* <strong>/config/scripts</strong>
  * Contains the scripts that are run
* <strong>/config/logs</strong>
  * Contains the log output from the script
* <strong>/config/cache</strong>
  * Contains the artist data cache to speed up processes
* <strong>/config/deemix</strong>
  * Contains deemix app data

<br />

# Lidarr Configuration Recommendations

## Media Management Settings:
* Disable Track Naming
  * Disabling track renaming enables synced lyrics that are imported as extras to be utilized by media players that support using them

#### Track Naming:

* Artist Folder: `{Artist Name}{ (Artist Disambiguation)}`
* Album Folder: `{Artist Name}{ - ALBUM TYPE}{ - Release Year} - {Album Title}{ ( Album Disambiguation)}`

#### Importing:
* Enable Import Extra Files
  * `lrc,jpg,png`

#### File Management
* Change File Date: Album Release Date
 
#### Permissions
* Enable Set Permissions
<br />
<br />
<br />
<br /> 


# Credits
- [Original Idea based on lidarr-download-automation by Migz93](https://github.com/Migz93/lidarr-download-automation)
- [Deemix download client](https://deemix.app/)
- [Musicbrainz](https://musicbrainz.org/)
- [Lidarr](https://lidarr.audio/)
- [r128gain](https://github.com/desbma/r128gain)
- [Algorithm Implementation/Strings/Levenshtein distance](https://en.wikibooks.org/wiki/Algorithm_Implementation/Strings/Levenshtein_distance)
- Icons made by <a href="http://www.freepik.com/" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/" title="Flaticon"> www.flaticon.com</a>
