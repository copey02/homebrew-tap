class Foodcli < Formula
  desc "FoodCLI - Search and fetch nutrition data from USDA FoodData Central"
  homepage "https://github.com/copey02/homebrew-tap"
  url "https://raw.githubusercontent.com/copey02/homebrew-tap/main/bin/foodcli"
  version "1.0.1"
  sha256 "e17c88bb4bbf18a9e3a0c60c4e3bc2f518516120c5699093e0981e28eeea932f"
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
        food search "chicken breast"          # Search foods
        food info 746771                      # Get nutrition info by FDC ID
        food nutrients 746771                 # Get nutrient breakdown
        food search "apple" --json            # JSON output for LLM use
    EOS
  end

  test do
    system "#{bin}/food", "--help"
  end
end
