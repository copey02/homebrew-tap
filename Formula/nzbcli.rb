class Nzbcli < Formula
  desc "NZB CLI - Search and download NZBs via NZBgeek or Prowlarr"
  homepage "https://github.com/copey02/homebrew-tap"
  url "https://raw.githubusercontent.com/copey02/homebrew-tap/main/bin/nzbcli"
  version "1.6.0"
  sha256 "303a0b1e2d85145d044ac7f10a29060535a28ee913abf843419948cdda1e9c6e"
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
