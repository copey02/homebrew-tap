class Mediacli < Formula
  desc "Media CLI - Rename and organize movies & TV shows using TMDB (FileBot alternative)"
  homepage "https://github.com/copey02/homebrew-tap"
  version "1.2.2"
  url "https://raw.githubusercontent.com/copey02/homebrew-tap/v#{version}/bin/mediacli"
  sha256 "07e8df6c39e8e689e7f9189ca6fb4ce8a7e75908043fdf8bd6df0dbee8144429"
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
        media info ~/Downloads/ --probe      Use ffprobe metadata
        media rename ~/Downloads/ --dry-run  Preview renames
        media rename ~/Downloads/ -y         Rename files
        media organize ~/Downloads/          Move to TV/Movie folders
    EOS
  end

  test do
    system "#{bin}/media", "--help"
  end
end
