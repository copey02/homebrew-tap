# Homebrew Tap

Personal Homebrew formulas for media automation tools.

## Installation

```bash
brew tap copey02/tap
brew install mediacli nzbcli sabcli tkcli trtcli sonarrcli tidarrcli foodcli
```

## Formulas

### mediacli (media)

MediaCLI - Rename and organize movies & TV shows using TMDB metadata.

```bash
media search "Severance"                    # Search TMDB
media info ~/Downloads/*.mkv --probe        # Show detected info with ffprobe
media rename ~/Downloads --dry-run          # Preview renames
media rename ~/Downloads --tmdb-id 1399 --tmdb-type tv
media organize ~/Downloads --dry-run        # Preview folder moves
```

### foodcli (food)

FoodCLI - Nutrition lookup from USDA FoodData Central and Open Food Facts.

```bash
food search "chicken breast"              # Search USDA (default)
food search "nutella" --source off        # Search Open Food Facts
food info 746771                          # USDA food by FDC ID
food info 3017620422003 --source off      # OFF product by barcode
food nutrients 746771 --all               # All nutrients
food search "apple" --json                # JSON output for LLM use
```

### tidarrcli (td)

Tidarr CLI - Browse Tidal catalog and manage Tidarr downloads.

```bash
td search "Artist Name"         # Search Tidal (artists, albums, tracks)
td search "Album" -t album      # Search albums only
td artist 12345                 # View artist releases by type
td album 67890                  # View album with track listing
td add 12345                    # Add album to download queue
td add "https://tidal.com/..."  # Add via Tidal URL
td queue                        # List download queue
td pause / resume               # Control queue
td history                      # View download history
td watch                        # Monitor until complete
```

### tkcli (tk)

Tracker CLI - Search and download from private trackers (BHD, Hawke).

```bash
tk search "Movie Name"          # Search all trackers (1080p default)
tk search "Movie" -t bhd        # Search Beyond-HD only
tk search "Movie" -r 2160p      # Search for 4K
tk get <url>                    # Download torrent file
tk get <url> -T                 # Download and add to torrent client
tk recent                       # Recent uploads
```

### trtcli (trt)

Torrent CLI - Control Transmission or qBittorrent.

```bash
trt list                        # List all torrents
trt list -d                     # Show downloading only
trt info 1                      # Detailed torrent info
trt add magnet:?...             # Add magnet link
trt add file.torrent            # Add torrent file
trt remove 1-5                  # Remove torrents
trt watch                       # Monitor until complete
```

### nzbcli (nzb)

NZBgeek CLI - Search and download NZBs from NZBgeek.

```bash
nzb search "Movie Name"           # Search (1080p default)
nzb search "Show S01" -c tv       # Search TV
nzb get <guid>                    # Download NZB
nzb recent -g FraMeSToR -c movies # Recent releases
```

### sabcli (sab)

SABnzbd CLI - Control SABnzbd from the command line.

```bash
sab status          # Queue status
sab queue           # List queue
sab add *.nzb       # Add NZB files
sab watch           # Monitor until complete
sab pause / resume  # Control queue
```

### sonarrcli (snr)

Sonarr CLI - Manage TV series and downloads via Sonarr API.

```bash
snr series                     # List series
snr search "Slow Horses"       # Search for series
snr add 362496 --search         # Add by TVDB ID
snr queue                       # Show download queue
snr wanted --all                # Missing episodes
```

## Configuration

After installation, create config files:

**~/.config/mediacli/config.json**
```json
{
  "tmdb_api_key": "YOUR_TMDB_API_KEY",
  "tv_pattern": "{show} ({year}) - S{season:02d}{episode_range} - {title}",
  "movie_pattern": "{title} ({year})",
  "tv_folder": "~/TV Shows",
  "movie_folder": "~/Movies"
}
```

**~/.config/tidarr/config.json**
```json
{
  "url": "http://localhost:8484",
  "password": "YOUR_TIDARR_PASSWORD"
}
```
Note: password is only needed if Tidarr auth is enabled.

**~/.config/trackers/config.json** (for tkcli)
```json
{
  "default_resolution": "1080p",
  "trackers": {
    "bhd": {"type": "bhd", "url": "https://beyond-hd.me", "api_key": "...", "rss_key": "..."},
    "hawke": {"type": "unit3d", "url": "https://hawke.uno", "api_key": "...", "rss_key": "..."}
  }
}
```

**~/.config/torrent/config.json** (for trtcli)
```json
{
  "url": "http://localhost:9091/transmission/rpc",
  "username": "admin",
  "password": "password"
}
```

**~/.config/nzbgeek/config.json**
```json
{
  "api_key": "YOUR_NZBGEEK_API_KEY",
  "api_url": "https://api.nzbgeek.info/api",
  "default_download_path": "~/Downloads",
  "default_resolution": "1080p"
}
```

**~/.config/sabnzbd/config.json**
```json
{
  "url": "http://localhost:8080",
  "api_key": "YOUR_SABNZBD_API_KEY"
}
```

**~/.config/foodcli/config.json**
```json
{
  "api_key": "YOUR_USDA_API_KEY"
}
```
Get your free API key at: https://fdc.nal.usda.gov/api-key-signup.html

**~/.config/sonarr/config.json**
```json
{
  "default_instance": "main",
  "instances": {
    "main": {
      "url": "http://localhost:8989",
      "api_key": "YOUR_SONARR_API_KEY"
    }
  }
}
```
