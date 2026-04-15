class StackedPrs < Formula
  desc "Manage stacked branches and pull requests"
  homepage "https://github.com/wyattjoh/stacked-prs"
  version "1.9.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v1.9.0/stacked-prs-aarch64-apple-darwin.tar.gz"
      sha256 "56e6d2b2b9782596be9f03cee5afe12c7747b4ca17e1a842f67ef91450a5150c"

      def install
        bin.install "stacked-prs"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v1.9.0/stacked-prs-x86_64-apple-darwin.tar.gz"
      sha256 "071a9b0505c816f367835b6c3d6c6cc0005091f4750bac47db2999fd3adeef8a"

      def install
        bin.install "stacked-prs"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v1.9.0/stacked-prs-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c4874e7adb29cefd855a7a1979406099db438a6bdb34f5e5c4d5360c65cd9ae9"

      def install
        bin.install "stacked-prs"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v1.9.0/stacked-prs-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f885e1564603d4631f1dacfd39383ef32868128f5d3d77a6baaf7c3bc9768fcd"

      def install
        bin.install "stacked-prs"
      end
    end
  end

  test do
    assert_match "stacked-prs", shell_output("#{bin}/stacked-prs --help 2>&1")
  end
end
