class StackedPrs < Formula
  desc "Manage stacked branches and pull requests"
  homepage "https://github.com/wyattjoh/stacked-prs"
  version "1.5.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v1.5.0/stacked-prs-aarch64-apple-darwin.tar.gz"
      sha256 "958f96410db60d3ecaeed40ba75c285ca30db830cb002f61bf0c656a461b7696"

      def install
        bin.install "stacked-prs"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v1.5.0/stacked-prs-x86_64-apple-darwin.tar.gz"
      sha256 "dbf00d5c371490a6d00be1d164b1513f4fc94b7bf260456da5795f1fc90259f3"

      def install
        bin.install "stacked-prs"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v1.5.0/stacked-prs-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "912f802a179b314c07e07b6f65dfc064cd8ac846b0e02e60dded5732ca9d8d0c"

      def install
        bin.install "stacked-prs"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v1.5.0/stacked-prs-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1ee7b960e78d4047e496f83cd1545cb8e7fff8e9c292738611f9907b80d63bf9"

      def install
        bin.install "stacked-prs"
      end
    end
  end

  test do
    assert_match "stacked-prs", shell_output("#{bin}/stacked-prs --help 2>&1")
  end
end
