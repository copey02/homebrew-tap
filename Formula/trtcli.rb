class Trtcli < Formula
  desc "Torrent CLI - Control Transmission or qBittorrent from the command line"
  homepage "https://github.com/copey02/homebrew-tap"
  url "https://raw.githubusercontent.com/copey02/homebrew-tap/main/bin/trtcli"
  version "1.0.0"
  sha256 "f7fbfa4efa7344f88b036c77b23331768de7c26e305dfb2dbd2f0a2e75d54772"
  license "MIT"

  depends_on "python@3"

  def install
    bin.install "trtcli" => "trt"
  end

  def caveats
    <<~EOS
      Create config file at ~/.config/torrent/config.json:

      For Transmission:
        {
          "client": "transmission",
          "url": "http://localhost:9091/transmission/rpc",
          "username": "your-username",
          "password": "your-password"
        }

      For qBittorrent:
        {
          "client": "qbittorrent",
          "url": "http://localhost:8080",
          "username": "admin",
          "password": "your-password"
        }

      Usage:
        trt list                  List all torrents
        trt list -d               Show downloading only
        trt add magnet:?xt=...    Add magnet link
        trt add file.torrent      Add torrent file
        trt remove 1 2 3          Remove torrents
        trt start all             Start all torrents
        trt stop all              Stop all torrents
        trt stats                 Session statistics
        trt watch                 Watch until complete
    EOS
  end

  test do
    system "#{bin}/trt", "--help"
  end
end
