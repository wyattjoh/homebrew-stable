class StackedPrs < Formula
  desc "Manage stacked branches and pull requests"
  homepage "https://github.com/wyattjoh/stacked-prs"
  version "1.2.4"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v1.2.4/stacked-prs-aarch64-apple-darwin.tar.gz"
      sha256 "b0e76461208a29667a4e9a30be58c94fe9e6df39ea446278271cfa41ea511f12"

      def install
        bin.install "stacked-prs"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v1.2.4/stacked-prs-x86_64-apple-darwin.tar.gz"
      sha256 "9bac989cbea8b3cda680a344d348033e681a9febf23e075ee5f49e213a9facef"

      def install
        bin.install "stacked-prs"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v1.2.4/stacked-prs-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3efb0de64c25d6713aa288c6f35d4963bc21ef7f3cc48918b3b1df167798a83e"

      def install
        bin.install "stacked-prs"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v1.2.4/stacked-prs-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c2bfd8b938f0ecc7e69e168b86889764bf49e6cb28d4ba41ba6221a78accafa2"

      def install
        bin.install "stacked-prs"
      end
    end
  end

  test do
    assert_match "stacked-prs", shell_output("#{bin}/stacked-prs --help 2>&1")
  end
end
