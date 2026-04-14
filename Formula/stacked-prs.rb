class StackedPrs < Formula
  desc "Manage stacked branches and pull requests"
  homepage "https://github.com/wyattjoh/stacked-prs"
  version "1.6.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v1.6.0/stacked-prs-aarch64-apple-darwin.tar.gz"
      sha256 "6de1adae0ac611fffeec1298493531cb64db17d2fa6ceb89ee4b9e203852f330"

      def install
        bin.install "stacked-prs"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v1.6.0/stacked-prs-x86_64-apple-darwin.tar.gz"
      sha256 "13d79b1348bb8df4a052ecfd8577921e5322d00b7ec70d013375296baf8c00a2"

      def install
        bin.install "stacked-prs"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v1.6.0/stacked-prs-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "53063520252d802cd48422d42c32d847cff6e9ef59057c65d690a7e4ccd9a350"

      def install
        bin.install "stacked-prs"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v1.6.0/stacked-prs-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0f6e6232edf8bb11bccdd24564a129d0d511348d58a23fde49b294c54858bafd"

      def install
        bin.install "stacked-prs"
      end
    end
  end

  test do
    assert_match "stacked-prs", shell_output("#{bin}/stacked-prs --help 2>&1")
  end
end
