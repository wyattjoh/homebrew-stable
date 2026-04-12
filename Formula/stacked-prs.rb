class StackedPrs < Formula
  desc "Manage stacked branches and pull requests"
  homepage "https://github.com/wyattjoh/stacked-prs"
  version "1.2.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v1.2.2/stacked-prs-aarch64-apple-darwin.tar.gz"
      sha256 "31d3d5b5d20ff7e3cdd373c543eb3b873dfec462de30b62d2861aa7baf5666dd"

      def install
        bin.install "stacked-prs"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v1.2.2/stacked-prs-x86_64-apple-darwin.tar.gz"
      sha256 "f4059c65d072ddc1dfcf7d57c29e5354e4b0718b36da01634ad63a739029ca32"

      def install
        bin.install "stacked-prs"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v1.2.2/stacked-prs-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "42b37873ce20e70d1c7b986701be92a035efc15c82cfba7b92c1e578fc580553"

      def install
        bin.install "stacked-prs"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v1.2.2/stacked-prs-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "9acfcb6db0bb960ae1a3746cecec9e52b5d0f7ad97ff1c622943b2cdb810259b"

      def install
        bin.install "stacked-prs"
      end
    end
  end

  test do
    assert_match "stacked-prs", shell_output("#{bin}/stacked-prs --help 2>&1")
  end
end
