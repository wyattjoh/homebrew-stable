class StackedPrs < Formula
  desc "Manage stacked branches and pull requests"
  homepage "https://github.com/wyattjoh/stacked-prs"
  version "2.4.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v2.4.0/stacked-prs-aarch64-apple-darwin.tar.gz"
      sha256 "55534940e9f0d73098e8dae05e5f8c7f7102fad3339b3c14b2cd4ea920f76f72"

      def install
        bin.install "stacked-prs"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v2.4.0/stacked-prs-x86_64-apple-darwin.tar.gz"
      sha256 "996f8bc9535a1ec9cbd52dd3dbb30ccc911a7be1feb4fa4d78339b696ae244a6"

      def install
        bin.install "stacked-prs"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v2.4.0/stacked-prs-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f576e1b7e738f3af04651998943ec6ddec7f4c421c150fd74520368b31f5e681"

      def install
        bin.install "stacked-prs"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v2.4.0/stacked-prs-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c31ad2c7c6d9bdd1a2919dba8582b54c4176d9b7979baff27a36ce8ae535b07d"

      def install
        bin.install "stacked-prs"
      end
    end
  end

  test do
    assert_match "stacked-prs", shell_output("#{bin}/stacked-prs --help 2>&1")
  end
end
