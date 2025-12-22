class Tmcli < Formula
  desc "Transmission CLI - Control Transmission BitTorrent client from the command line"
  homepage "https://github.com/copey02/homebrew-tap"
  url "https://raw.githubusercontent.com/copey02/homebrew-tap/main/bin/tmcli"
  version "1.0.0"
  license "MIT"

  depends_on "python@3"

  def install
    bin.install "tmcli" => "tm"
  end

  def caveats
    <<~EOS
      Create config file at ~/.config/transmission/config.json:
        {
          "url": "http://localhost:9091/transmission/rpc",
          "username": "your-username",
          "password": "your-password"
        }
    EOS
  end

  test do
    system "#{bin}/tm", "--help"
  end
end
