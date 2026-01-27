class Nzbcli < Formula
  desc "NZB CLI - Search and download NZBs via NZBgeek or Prowlarr"
  homepage "https://github.com/copey02/homebrew-tap"
  url "https://raw.githubusercontent.com/copey02/homebrew-tap/main/bin/nzbcli"
  version "1.5.0"
  sha256 "f5c5fa0cf251c96d06b999a21bf0093c1a82604124766b12b0ced569bf573688"
  license "MIT"

  depends_on "python@3"

  def install
    bin.install "nzbcli" => "nzb"
  end

  def caveats
    <<~EOS
      Create config file at ~/.config/nzbgeek/config.json:
        {
          "api_key": "YOUR_API_KEY",
          "api_url": "https://api.nzbgeek.info/api",
          "prowlarr_url": "http://localhost:9696",
          "prowlarr_api_key": "YOUR_PROWLARR_API_KEY",
          "default_download_path": "~/Downloads",
          "default_resolution": "1080p"
        }
    EOS
  end

  test do
    system "#{bin}/nzb", "--help"
  end
end
