# Homebrew Tap

Personal Homebrew formulas for media automation tools.

## Installation

```bash
brew tap copey02/tap
brew install nzbcli sabcli tkcli tmcli tidarrcli foodcli
```

## Formulas

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
tk get <url> --add-to-tm        # Download and add to Transmission
tk recent                       # Recent uploads
```

### tmcli (tm)

Transmission CLI - Control Transmission BitTorrent client.

```bash
tm list                         # List all torrents
tm list -f downloading          # Filter by status
tm info 1                       # Detailed torrent info
tm add magnet:?...              # Add magnet link
tm add file.torrent             # Add torrent file
tm remove 1-5                   # Remove torrents
tm watch                        # Monitor until complete
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

## Configuration

After installation, create config files:

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

**~/.config/transmission/config.json** (for tmcli)
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
