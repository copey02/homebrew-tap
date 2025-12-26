class Sonarrcli < Formula
  desc "Sonarr CLI - Manage TV series and downloads via Sonarr API"
  homepage "https://github.com/copey02/homebrew-tap"
  url "https://raw.githubusercontent.com/copey02/homebrew-tap/main/bin/sonarrcli"
  version "1.0.1"
  sha256 "3987d3a8a5f6f4f476ba04dd296c4545e91c1ee245668b58d1a27d0f33575857"
  license "MIT"

  depends_on "python@3"

  def install
    bin.install "sonarrcli" => "snr"
  end

  def caveats
    <<~EOS
      Create config file at ~/.config/sonarr/config.json:
        {
          "default_instance": "main",
          "default_root_folder": "/tv",
          "default_quality_profile": "HD-1080p",
          "instances": {
            "main": {
              "url": "http://localhost:8989",
              "api_key": "your-api-key"
            },
            "4k": {
              "url": "http://localhost:8990",
              "api_key": "your-4k-api-key"
            }
          }
        }

      Get your API key from Sonarr: Settings > General > Security

      Usage:
        snr series                  List all series
        snr search "Breaking Bad"   Search for a series
        snr add 81189               Add series by TVDB ID
        snr queue                   Show download queue
        snr calendar                Upcoming episodes
        snr wanted                  Missing episodes
        snr -I 4k series            Use a different instance
    EOS
  end

  test do
    system "#{bin}/snr", "--help"
  end
end
