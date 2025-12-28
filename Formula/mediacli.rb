class Mediacli < Formula
  desc "Media CLI - Rename and organize movies & TV shows using TMDB (FileBot alternative)"
  homepage "https://github.com/copey02/homebrew-tap"
  url "https://raw.githubusercontent.com/copey02/homebrew-tap/main/bin/mediacli"
  version "1.0.0"
  sha256 "213dca5a2b18d9fad1f513bcab620b4078f87bdefd7977e15ac55a5569fb9821"
  license "MIT"

  depends_on "python@3"

  def install
    bin.install "mediacli" => "media"
  end

  def caveats
    <<~EOS
      Get free TMDB API key at: https://www.themoviedb.org/settings/api

      Setup: media config --set tmdb_api_key=YOUR_KEY

      Naming format (Sonarr-compatible):
        Show (Year) - S01E01 - Episode [Bluray-1080p REMUX][HDR][Audio][Codec][10bit]-Group.mkv

      Usage:
        media search "Breaking Bad"          Search TMDB
        media info ~/Downloads/              Show detected info
        media rename ~/Downloads/ --dry-run  Preview renames
        media rename ~/Downloads/ -y         Rename files
        media organize ~/Downloads/          Move to TV/Movie folders
    EOS
  end

  test do
    system "#{bin}/media", "--help"
  end
end
