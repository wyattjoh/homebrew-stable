class StackedPrs < Formula
  desc "Manage stacked branches and pull requests"
  homepage "https://github.com/wyattjoh/stacked-prs"
  version "1.7.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v1.7.0/stacked-prs-aarch64-apple-darwin.tar.gz"
      sha256 "d2f07298f089e176e520d5201715ccfdf07aaa8224687c7840eb6aa1a887bc5d"

      def install
        bin.install "stacked-prs"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v1.7.0/stacked-prs-x86_64-apple-darwin.tar.gz"
      sha256 "35cf93e7b265f3a651fa2f39ead1ca784973ffd428cc53c5fec24f3ed3b22c53"

      def install
        bin.install "stacked-prs"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v1.7.0/stacked-prs-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8e81ed7e518eb398c3a06886230ebfa5c2ca93296df6da4e407a72ca4af0164b"

      def install
        bin.install "stacked-prs"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v1.7.0/stacked-prs-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "097374ed7840ddc03f2529507fe6b683215ad1e71fbed53ea77bf635cc142976"

      def install
        bin.install "stacked-prs"
      end
    end
  end

  test do
    assert_match "stacked-prs", shell_output("#{bin}/stacked-prs --help 2>&1")
  end
end
