class Nzbcli < Formula
  desc "NZBgeek CLI - Search and download NZBs from NZBgeek"
  homepage "https://github.com/copey02/homebrew-tap"
  url "https://raw.githubusercontent.com/copey02/homebrew-tap/main/bin/nzbcli"
  version "1.1.0"
  sha256 "cf4c51389645c76219f1b233d3ec8cf96ad2df4c25f5a529e25f1f18fbf79b26"
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
          "default_download_path": "~/Downloads",
          "default_resolution": "1080p"
        }
    EOS
  end

  test do
    system "#{bin}/nzb", "--help"
  end
end
