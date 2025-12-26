class Sabcli < Formula
  desc "SABnzbd CLI - Control SABnzbd from the command line"
  homepage "https://github.com/copey02/homebrew-tap"
  url "https://raw.githubusercontent.com/copey02/homebrew-tap/main/bin/sabcli"
  version "1.2.0"
  sha256 "751bfdf4b36de4a50ca0cdd6aff3dd7e26fa44283c020a4789954b33fbdf7768"
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
