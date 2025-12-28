class Sabcli < Formula
  desc "SABnzbd CLI - Control SABnzbd from the command line"
  homepage "https://github.com/copey02/homebrew-tap"
  url "https://raw.githubusercontent.com/copey02/homebrew-tap/main/bin/sabcli"
  version "1.2.1"
  sha256 "bcf91238e1e562c71db470aa6ef724f644cbe4bc2a98e0fe56498dfc1ff8fd6d"
  license "MIT"

  depends_on "python@3"

  def install
    bin.install "sabcli" => "sab"
  end

  def caveats
    <<~EOS
      Create config file at ~/.config/sabnzbd/config.json:
        {
          "url": "http://localhost:8080",
          "api_key": "YOUR_API_KEY"
        }
    EOS
  end

  test do
    system "#{bin}/sab", "--help"
  end
end
