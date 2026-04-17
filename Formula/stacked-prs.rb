class StackedPrs < Formula
  desc "Manage stacked branches and pull requests"
  homepage "https://github.com/wyattjoh/stacked-prs"
  version "2.0.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v2.0.0/stacked-prs-aarch64-apple-darwin.tar.gz"
      sha256 "4a8b367c967c3dc190681deb27443c9e9183870841164c7acae2b6eed939806c"

      def install
        bin.install "stacked-prs"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v2.0.0/stacked-prs-x86_64-apple-darwin.tar.gz"
      sha256 "42ffdd3d367ec5a1753c01a593d5f7d9f033c250db8a78cd66efd55d37fcc39a"

      def install
        bin.install "stacked-prs"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v2.0.0/stacked-prs-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c05a9cdb1cf1053c3955ed45ead323fb7ffa83db24424bd0111c110cdb8d0a36"

      def install
        bin.install "stacked-prs"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v2.0.0/stacked-prs-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b0f3ef22fec707787dbca187d9426fb0146237487d217bbc0fdb3b93e3e50572"

      def install
        bin.install "stacked-prs"
      end
    end
  end

  test do
    assert_match "stacked-prs", shell_output("#{bin}/stacked-prs --help 2>&1")
  end
end
