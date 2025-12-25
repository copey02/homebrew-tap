class Foodcli < Formula
  desc "FoodCLI - Nutrition lookup from USDA and Open Food Facts"
  homepage "https://github.com/copey02/homebrew-tap"
  url "https://raw.githubusercontent.com/copey02/homebrew-tap/main/bin/foodcli"
  version "1.1.0"
  sha256 "ad17748b321de3d8654a8667a2b51d71b802a28b179df7a4c3f49db6ade0848b"
  license "MIT"

  depends_on "python@3"

  def install
    bin.install "foodcli" => "food"
  end

  def caveats
    <<~EOS
      Sources:
        usda  - USDA FoodData Central (requires API key)
        off   - Open Food Facts (no API key, global products)

      Config (only needed for USDA):
        mkdir -p ~/.config/foodcli
        echo '{"api_key": "YOUR_KEY"}' > ~/.config/foodcli/config.json
        Get free key: https://fdc.nal.usda.gov/api-key-signup.html

      Usage:
        food search "chicken"                     # Search USDA
        food search "nutella" --source off        # Search Open Food Facts
        food info 746771                          # USDA by FDC ID
        food info 3017620422003 --source off      # OFF by barcode
    EOS
  end

  test do
    system "#{bin}/food", "--help"
  end
end
