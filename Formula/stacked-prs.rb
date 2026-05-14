class StackedPrs < Formula
  desc "Manage stacked branches and pull requests"
  homepage "https://github.com/wyattjoh/stacked-prs"
  version "2.4.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v2.4.2/stacked-prs-aarch64-apple-darwin.tar.gz"
      sha256 "f8acbc99fb4df2833cf32d3bb2afd75e5c6cc6b690beaa57fbd7ac8e52f001df"

      def install
        bin.install "stacked-prs"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v2.4.2/stacked-prs-x86_64-apple-darwin.tar.gz"
      sha256 "4a769f18178059a0033f7d44a4535555d42e0db65df309bcb0e858999029a1a0"

      def install
        bin.install "stacked-prs"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v2.4.2/stacked-prs-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "81791fbfe0ebeb5f5d504520e8c426c2e8b4b626686300d82f83f65e55669fef"

      def install
        bin.install "stacked-prs"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v2.4.2/stacked-prs-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ba505c1d9c55407fea21e49662fc03025636105e6f79f8482e52182bb1cb322f"

      def install
        bin.install "stacked-prs"
      end
    end
  end

  test do
    assert_match "stacked-prs", shell_output("#{bin}/stacked-prs --help 2>&1")
  end
end
