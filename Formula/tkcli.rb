class Tkcli < Formula
  desc "Tracker CLI - Search and download from private trackers (BHD, Hawke)"
  homepage "https://github.com/copey02/homebrew-tap"
  url "https://raw.githubusercontent.com/copey02/homebrew-tap/main/bin/tkcli"
  version "1.1.0"
  sha256 "c3cbb50aec844f2745561ddf76e7130d068fca94495c3387e54546fd2883a717"
  license "MIT"

  depends_on "python@3"

  def install
    bin.install "tkcli" => "tk"
  end

  def caveats
    <<~EOS
      Create config file at ~/.config/trackers/config.json:
        {
          "default_resolution": "1080p",
          "default_download_path": "~/Downloads/torrents",
          "trackers": {
            "bhd": {
              "type": "bhd",
              "url": "https://beyond-hd.me",
              "api_key": "your-api-key",
              "rss_key": "your-rss-key"
            },
            "hawke": {
              "type": "unit3d",
              "url": "https://hawke.uno",
              "api_key": "your-api-token",
              "rss_key": "your-rss-key"
            }
          }
        }

      Get your API keys:
        BHD: https://beyond-hd.me/my-security (API Key + RSS Key)
        Hawke: https://hawke.uno/users/your-username/apikeys

      Usage:
        tk search "Movie Name"        # Search all trackers
        tk search "Movie" -T          # Search and add all to torrent client
        tk search "Movie" -T 1,2      # Add specific results
        tk recent -t hawke            # Recent uploads from Hawke
    EOS
  end

  test do
    system "#{bin}/tk", "--help"
  end
end
