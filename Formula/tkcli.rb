class Tkcli < Formula
  desc "Tracker CLI - Search private trackers (BHD, UNIT3D, FileList, TorrentLeech)"
  homepage "https://github.com/copey02/homebrew-tap"
  url "https://raw.githubusercontent.com/copey02/homebrew-tap/main/bin/tkcli"
  version "1.2.0"
  sha256 "897830dd037d2fa00e23e86501a6d8698aafdc29ccef43848ca38bc7306a8e1a"
  license "MIT"

  depends_on "python@3"

  def install
    bin.install "tkcli" => "tk"
  end

  def caveats
    <<~EOS
      Supported trackers:
        bhd   - Beyond-HD (type: bhd)
        hawke - Hawke.uno (type: unit3d)
        fnp   - FearNoPeer (type: unit3d)
        fl    - FileList (type: filelist)
        tl    - TorrentLeech (type: torrentleech)

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
