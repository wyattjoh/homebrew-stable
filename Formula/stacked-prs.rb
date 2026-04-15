class StackedPrs < Formula
  desc "Manage stacked branches and pull requests"
  homepage "https://github.com/wyattjoh/stacked-prs"
  version "1.9.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v1.9.1/stacked-prs-aarch64-apple-darwin.tar.gz"
      sha256 "57e0a6e514007d45f2b7bb39a5d1165dff247e8e98d83d635cde749ed3389a96"

      def install
        bin.install "stacked-prs"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v1.9.1/stacked-prs-x86_64-apple-darwin.tar.gz"
      sha256 "1890afc84c184bccd7540d69b9f3c5c47b4a69c369b74acdc09b57bed67bfc26"

      def install
        bin.install "stacked-prs"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v1.9.1/stacked-prs-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3c0982fd416b2e3f5af21a8493be9b3e845d2c49cf4ba6af5fcbd42353f5980b"

      def install
        bin.install "stacked-prs"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v1.9.1/stacked-prs-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5fa18b0b902b44ecb664995abba83dcc191b023109919218c371bb16e4c605ad"

      def install
        bin.install "stacked-prs"
      end
    end
  end

  test do
    assert_match "stacked-prs", shell_output("#{bin}/stacked-prs --help 2>&1")
  end
end
