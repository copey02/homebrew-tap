class Sabcli < Formula
  desc "SABnzbd CLI - Control SABnzbd from the command line"
  homepage "https://github.com/copey02/homebrew-tap"
  url "https://raw.githubusercontent.com/copey02/homebrew-tap/main/bin/sabcli"
  version "1.0.0"
  sha256 "48a00c8714257db0d9cdbd1d5f31c125df6d30fb7e9db54c84211940133f28a2"
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
