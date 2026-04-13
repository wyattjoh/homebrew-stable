class StackedPrs < Formula
  desc "Manage stacked branches and pull requests"
  homepage "https://github.com/wyattjoh/stacked-prs"
  version "1.3.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v1.3.1/stacked-prs-aarch64-apple-darwin.tar.gz"
      sha256 "8c03a46ac27bb4b3ffc203c1333a6102c0e42b437841855e7e8e00c963ac3270"

      def install
        bin.install "stacked-prs"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v1.3.1/stacked-prs-x86_64-apple-darwin.tar.gz"
      sha256 "83f1f225cf30abe13fa292f5ffc6d2588a1f5ff158ca707cc9c0f181cd65889b"

      def install
        bin.install "stacked-prs"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v1.3.1/stacked-prs-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d8bf45e71b36ab157cbfab6a8089d47eade794da6ded532691131abcfb507a70"

      def install
        bin.install "stacked-prs"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v1.3.1/stacked-prs-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "56580b98c2a6bd61aa92f90dccdfef20d3a995d5b8c2db5d902ff71b2494d7ee"

      def install
        bin.install "stacked-prs"
      end
    end
  end

  test do
    assert_match "stacked-prs", shell_output("#{bin}/stacked-prs --help 2>&1")
  end
end
