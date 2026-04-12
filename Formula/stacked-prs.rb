class StackedPrs < Formula
  desc "Manage stacked branches and pull requests"
  homepage "https://github.com/wyattjoh/stacked-prs"
  version "1.3.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v1.3.0/stacked-prs-aarch64-apple-darwin.tar.gz"
      sha256 "9db7b4dc260f01fec9efc94d0528b591b5a22097fa331b17b8fe70130a4185b5"

      def install
        bin.install "stacked-prs"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v1.3.0/stacked-prs-x86_64-apple-darwin.tar.gz"
      sha256 "265d066292faebb150f9220de797a7fce470bc8ebf68e1a25151b74ef9c28d75"

      def install
        bin.install "stacked-prs"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v1.3.0/stacked-prs-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "095bd9c2f0781ca04d57ada525b5578cb075be058ee8ecb41577257d00f8be53"

      def install
        bin.install "stacked-prs"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v1.3.0/stacked-prs-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "67414523a35d8d64ce56b033f4a7d2e02e5e4aaf32b2f0e04ccd22cad07333a3"

      def install
        bin.install "stacked-prs"
      end
    end
  end

  test do
    assert_match "stacked-prs", shell_output("#{bin}/stacked-prs --help 2>&1")
  end
end
