class Nzbcli < Formula
  desc "NZB CLI - Search and download NZBs via NZBgeek or Prowlarr"
  homepage "https://github.com/copey02/homebrew-tap"
  url "https://raw.githubusercontent.com/copey02/homebrew-tap/main/bin/nzbcli"
  version "1.2.0"
  sha256 "14c158f79cae69cb064d569a6a77190d0eed395e67f809bdf1184db06ed40801"
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
