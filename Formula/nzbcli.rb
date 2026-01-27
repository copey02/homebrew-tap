class Nzbcli < Formula
  desc "NZB CLI - Search and download NZBs via NZBgeek or Prowlarr"
  homepage "https://github.com/copey02/homebrew-tap"
  url "https://raw.githubusercontent.com/copey02/homebrew-tap/main/bin/nzbcli"
  version "1.3.0"
  sha256 "22a61f25b671d30519c4aeff425fef5b7cd9a5d6be7b1e36303d2b22a0e1623e"
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
