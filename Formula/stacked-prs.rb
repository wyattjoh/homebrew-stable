class StackedPrs < Formula
  desc "Manage stacked branches and pull requests"
  homepage "https://github.com/wyattjoh/stacked-prs"
  version "1.2.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v1.2.3/stacked-prs-aarch64-apple-darwin.tar.gz"
      sha256 "bbb36e8446536a1b5389a2bd13da4e35247cc990ca19fd865cdeafd9bacdce9c"

      def install
        bin.install "stacked-prs"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v1.2.3/stacked-prs-x86_64-apple-darwin.tar.gz"
      sha256 "c0a55d9e3689fb3bb0e68a6a7fdaf76b7bf37d7ec0142355391b3186801cd9f3"

      def install
        bin.install "stacked-prs"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v1.2.3/stacked-prs-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6fa19cb1d4fe333ffabc29137c3ef2e6f51351087449512c09c281c832958bff"

      def install
        bin.install "stacked-prs"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v1.2.3/stacked-prs-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "db59a9b3979d543211a324db826044e99d3b630f98fbe67bcdd6af52e9076b4d"

      def install
        bin.install "stacked-prs"
      end
    end
  end

  test do
    assert_match "stacked-prs", shell_output("#{bin}/stacked-prs --help 2>&1")
  end
end
