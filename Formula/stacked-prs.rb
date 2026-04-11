class StackedPrs < Formula
  desc "Manage stacked branches and pull requests"
  homepage "https://github.com/wyattjoh/stacked-prs"
  version "1.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v1.1.0/stacked-prs-aarch64-apple-darwin.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"

      def install
        bin.install "stacked-prs"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v1.1.0/stacked-prs-x86_64-apple-darwin.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"

      def install
        bin.install "stacked-prs"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v1.1.0/stacked-prs-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"

      def install
        bin.install "stacked-prs"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v1.1.0/stacked-prs-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"

      def install
        bin.install "stacked-prs"
      end
    end
  end

  test do
    assert_match "stacked-prs", shell_output("#{bin}/stacked-prs --help 2>&1")
  end
end
