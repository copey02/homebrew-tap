class Foodcli < Formula
  desc "FoodCLI - Search and fetch nutrition data from USDA FoodData Central"
  homepage "https://github.com/copey02/homebrew-tap"
  url "https://raw.githubusercontent.com/copey02/homebrew-tap/main/bin/foodcli"
  version "1.0.0"
  sha256 "60388107d33f1cfe21a88e92892eb5a829e2447be68521f53182fc9637256b18"
  license "MIT"

  depends_on "python@3"

  def install
    bin.install "foodcli" => "food"
  end

  def caveats
    <<~EOS
      Create config file at ~/.config/foodcli/config.json:
        {
          "api_key": "YOUR_API_KEY"
        }

      Get your free API key at:
        https://fdc.nal.usda.gov/api-key-signup.html

      Usage:
        food search "chicken breast"          # Search foods (JSON output)
        food search "apple" --table           # Human-readable output
        food info 746771                      # Get nutrition info by FDC ID
        food nutrients 746771                 # Get nutrient breakdown

      Output is JSON by default (optimized for LLM/programmatic use).
    EOS
  end

  test do
    system "#{bin}/food", "--help"
  end
end
