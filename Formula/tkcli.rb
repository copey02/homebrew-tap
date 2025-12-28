class Tkcli < Formula
  desc "Tracker CLI - Search private trackers (BHD, UNIT3D, FileList, TorrentLeech)"
  homepage "https://github.com/copey02/homebrew-tap"
  url "https://raw.githubusercontent.com/copey02/homebrew-tap/main/bin/tkcli"
  version "1.3.2"
  sha256 "d337bca981f2b643810a5c5cd8e2335444dec638d45ce111937f9cd63c381313"
  license "MIT"

  depends_on "python@3"

  def install
    bin.install "tkcli" => "tk"
  end

  def caveats
    <<~EOS
      Supported trackers:
        bhd   - Beyond-HD (type: bhd, api_key + rss_key)
        hawke - Hawke.uno (type: unit3d, api_key + rss_key)
        fnp   - FearNoPeer (type: unit3d, api_key + rss_key)
        fl    - FileList (type: filelist, username + passkey)
        tl    - TorrentLeech (type: torrentleech, username + password)

      Config: ~/.config/trackers/config.json

      Usage:
        tk search "Movie"             # Search all trackers
        tk search "Movie" -t bhd      # Search specific tracker
        tk search "Movie" -T          # Add all to torrent client
        tk search "Movie" -T 1,2      # Add specific results
    EOS
  end

  test do
    system "#{bin}/tk", "--help"
  end
end
