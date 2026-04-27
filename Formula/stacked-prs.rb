class StackedPrs < Formula
  desc "Manage stacked branches and pull requests"
  homepage "https://github.com/wyattjoh/stacked-prs"
  version "2.3.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v2.3.0/stacked-prs-aarch64-apple-darwin.tar.gz"
      sha256 "6a76950a728f69a6a0a5cc565549dc0909eebf5715c1594020a5d4c6a977e142"

      def install
        bin.install "stacked-prs"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v2.3.0/stacked-prs-x86_64-apple-darwin.tar.gz"
      sha256 "f224edef6848eeb021de7904226ef96322be3727ff122279171e9da938da53b8"

      def install
        bin.install "stacked-prs"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v2.3.0/stacked-prs-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f00ea9ad123849d185e778ef9166f9e31899ad3096723ede49f7d5cf5d55e3d5"

      def install
        bin.install "stacked-prs"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v2.3.0/stacked-prs-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "99aae7591648dbe6270bf6d7b2f5a37c883572b51e918644fba1710a04326df7"

      def install
        bin.install "stacked-prs"
      end
    end
  end

  test do
    assert_match "stacked-prs", shell_output("#{bin}/stacked-prs --help 2>&1")
  end
end
