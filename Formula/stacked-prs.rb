class StackedPrs < Formula
  desc "Manage stacked branches and pull requests"
  homepage "https://github.com/wyattjoh/stacked-prs"
  version "2.2.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v2.2.1/stacked-prs-aarch64-apple-darwin.tar.gz"
      sha256 "d176b4eb52493ee630c2640f4fb8b09964e0d8f549dce14d264e69fda7098255"

      def install
        bin.install "stacked-prs"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v2.2.1/stacked-prs-x86_64-apple-darwin.tar.gz"
      sha256 "ae30f561ffe89b8bde02188ef7485c5583f682b0d07c5db1069d9738f8645822"

      def install
        bin.install "stacked-prs"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v2.2.1/stacked-prs-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "4539db2dc811331289859257abcfae55dd472d9d39824794702f7cfdead5d294"

      def install
        bin.install "stacked-prs"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v2.2.1/stacked-prs-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ec6984ae77a98e0717f22367f8befc48a1b8cd5a3f4946e44104bc9ae222a6a9"

      def install
        bin.install "stacked-prs"
      end
    end
  end

  test do
    assert_match "stacked-prs", shell_output("#{bin}/stacked-prs --help 2>&1")
  end
end
