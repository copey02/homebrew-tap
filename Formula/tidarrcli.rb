class Tidarrcli < Formula
  desc "Tidarr CLI - Browse Tidal catalog and manage Tidarr downloads"
  homepage "https://github.com/copey02/homebrew-tap"
  url "https://raw.githubusercontent.com/copey02/homebrew-tap/main/bin/tidarrcli"
  version "1.0.0"
  license "MIT"

  depends_on "python@3"

  def install
    bin.install "tidarrcli" => "td"
  end

  def caveats
    <<~EOS
      Create config file at ~/.config/tidarr/config.json:
        {
          "url": "http://localhost:8484",
          "password": "your-tidarr-password"
        }

      Note: password is only required if Tidarr auth is enabled.

      Commands:
        td search "Artist"     # Search Tidal catalog
        td artist 12345        # View artist releases by type
        td album 67890         # View album tracks
        td add 12345           # Add album to queue
        td queue               # List queue
        td watch               # Monitor until complete
    EOS
  end

  test do
    system "#{bin}/td", "--help"
  end
end
