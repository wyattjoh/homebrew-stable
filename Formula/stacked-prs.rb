class StackedPrs < Formula
  desc "Manage stacked branches and pull requests"
  homepage "https://github.com/wyattjoh/stacked-prs"
  version "2.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v2.1.0/stacked-prs-aarch64-apple-darwin.tar.gz"
      sha256 "837936e341505b779939349cd95a34e006422a25046bddb0ab369c5b3924d9bb"

      def install
        bin.install "stacked-prs"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v2.1.0/stacked-prs-x86_64-apple-darwin.tar.gz"
      sha256 "068311b7bec2bfd5651ea0405669ad5d87f591911eb8145a32d03e8b09aff561"

      def install
        bin.install "stacked-prs"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v2.1.0/stacked-prs-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "9b59cad37a28e7b986da143ad828c9440994e8d2ebfe9a4cf22920a86a08c4df"

      def install
        bin.install "stacked-prs"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v2.1.0/stacked-prs-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8fdb073fbf7f39628a5d6acbcc0da4f47bf07205eb30cba2f3f53eedcbadfc32"

      def install
        bin.install "stacked-prs"
      end
    end
  end

  test do
    assert_match "stacked-prs", shell_output("#{bin}/stacked-prs --help 2>&1")
  end
end
