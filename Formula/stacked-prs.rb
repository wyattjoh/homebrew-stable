class StackedPrs < Formula
  desc "Manage stacked branches and pull requests"
  homepage "https://github.com/wyattjoh/stacked-prs"
  version "1.8.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v1.8.0/stacked-prs-aarch64-apple-darwin.tar.gz"
      sha256 "fb22e164eb8de24e5244f30ec037a053832a6c0012ccd5c4bb74332f99e5d97a"

      def install
        bin.install "stacked-prs"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v1.8.0/stacked-prs-x86_64-apple-darwin.tar.gz"
      sha256 "d589103d4168ea552ec41287f2fdda0522e5da4ad976a298908d1f973e5aa94d"

      def install
        bin.install "stacked-prs"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v1.8.0/stacked-prs-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "bb6b85cfac457115165917e3e6b9b3c4308fe8f5749ac5fbfd1bcea8d2c00b41"

      def install
        bin.install "stacked-prs"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v1.8.0/stacked-prs-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3d45ca2c2e588c1ae27cbc4d01c04dfb31d32af0b21db55f457164859d0ae6d6"

      def install
        bin.install "stacked-prs"
      end
    end
  end

  test do
    assert_match "stacked-prs", shell_output("#{bin}/stacked-prs --help 2>&1")
  end
end
