class StackedPrs < Formula
  desc "Manage stacked branches and pull requests"
  homepage "https://github.com/wyattjoh/stacked-prs"
  version "1.4.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v1.4.0/stacked-prs-aarch64-apple-darwin.tar.gz"
      sha256 "7fd9b93f13829795f041d93152d181a49d025916f506007ffa11e739bbb33a50"

      def install
        bin.install "stacked-prs"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v1.4.0/stacked-prs-x86_64-apple-darwin.tar.gz"
      sha256 "3c9d711e2d379c94e1a9402ff4b796ea6e80e6b5d9e71b6cfa24780b8dc6b961"

      def install
        bin.install "stacked-prs"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v1.4.0/stacked-prs-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "028d0995ec8ae6f5fc220dce9b3bba489197f58146a7de181fe9830314702de5"

      def install
        bin.install "stacked-prs"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v1.4.0/stacked-prs-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e47524bc7d9afbf44921b3761995a0f0e8a60f28a9415ce87391e809fcf791cf"

      def install
        bin.install "stacked-prs"
      end
    end
  end

  test do
    assert_match "stacked-prs", shell_output("#{bin}/stacked-prs --help 2>&1")
  end
end
