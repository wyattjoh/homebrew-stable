class StackedPrs < Formula
  desc "Manage stacked branches and pull requests"
  homepage "https://github.com/wyattjoh/stacked-prs"
  version "1.10.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v1.10.0/stacked-prs-aarch64-apple-darwin.tar.gz"
      sha256 "3e0050cf34ff72a238f00886f3345208cc21958733a6f7996a0befb7c929079f"

      def install
        bin.install "stacked-prs"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v1.10.0/stacked-prs-x86_64-apple-darwin.tar.gz"
      sha256 "a02c2c21ff6f9c5816f10f7a7c30dc19f85e60936fdd8fb731c48b9f6dfbd3bc"

      def install
        bin.install "stacked-prs"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v1.10.0/stacked-prs-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d3d9d0a6c78b34f2dadb0e7352fa9060d9d5413346354be9faf5c373d722341f"

      def install
        bin.install "stacked-prs"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v1.10.0/stacked-prs-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d9051b5726d598fd635d62208f07f436326e91d54f3cd4bed7becc6d72977c5f"

      def install
        bin.install "stacked-prs"
      end
    end
  end

  test do
    assert_match "stacked-prs", shell_output("#{bin}/stacked-prs --help 2>&1")
  end
end
