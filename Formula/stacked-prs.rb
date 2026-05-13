class StackedPrs < Formula
  desc "Manage stacked branches and pull requests"
  homepage "https://github.com/wyattjoh/stacked-prs"
  version "2.4.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v2.4.1/stacked-prs-aarch64-apple-darwin.tar.gz"
      sha256 "d596a081a1efff6159dd460f622abf4acc004f445c52f15209863a053fc67bf9"

      def install
        bin.install "stacked-prs"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v2.4.1/stacked-prs-x86_64-apple-darwin.tar.gz"
      sha256 "f637e044f7ade06f6788288f9da8721ca34f4c53dd8b461d6604e7d44fe70e3c"

      def install
        bin.install "stacked-prs"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v2.4.1/stacked-prs-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f274fe0d631e04feb365749cdf0faf0cf91dcf8706d4b906121862ce7a8b308b"

      def install
        bin.install "stacked-prs"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v2.4.1/stacked-prs-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "cfc3a2c406c8faeaa4e692b16c8a2948e5aaf7a621905313938093cc3849ebb4"

      def install
        bin.install "stacked-prs"
      end
    end
  end

  test do
    assert_match "stacked-prs", shell_output("#{bin}/stacked-prs --help 2>&1")
  end
end
