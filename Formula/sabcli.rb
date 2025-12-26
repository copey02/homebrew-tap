class Sabcli < Formula
  desc "SABnzbd CLI - Control SABnzbd from the command line"
  homepage "https://github.com/copey02/homebrew-tap"
  url "https://raw.githubusercontent.com/copey02/homebrew-tap/main/bin/sabcli"
  version "1.1.0"
  sha256 "661d7636fb8428ddb4d469823ca5213d3c214d607cd81de5df8e3681b311dac4"
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
