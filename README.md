# Homebrew Tap

Personal Homebrew formulas for media automation tools.

## Installation

```bash
brew tap copey02/tap
brew install nzbcli sabcli
```

## Formulas

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
