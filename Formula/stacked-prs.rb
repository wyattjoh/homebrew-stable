class StackedPrs < Formula
  desc "Manage stacked branches and pull requests"
  homepage "https://github.com/wyattjoh/stacked-prs"
  version "2.6.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v2.6.0/stacked-prs-aarch64-apple-darwin.tar.gz"
      sha256 "58f32c718b825eff5f6a045c063b3cd209c68b7d8e0b9b5ac5a4f745420b1760"

      def install
        bin.install "stacked-prs"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v2.6.0/stacked-prs-x86_64-apple-darwin.tar.gz"
      sha256 "f468d481eff82cc300df73f93935b54c34749c0ae604a212db9dc80476923b4f"

      def install
        bin.install "stacked-prs"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v2.6.0/stacked-prs-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "fe918ffa83ff844f4892950f083a345afda89bff5b2f3ae2acfa39f9f352dc41"

      def install
        bin.install "stacked-prs"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v2.6.0/stacked-prs-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "34e5cdb30bce82254195c2924757cc2e42cd5b79b5d94a25ca3e60c657da9b5a"

      def install
        bin.install "stacked-prs"
      end
    end
  end

  test do
    assert_match "stacked-prs", shell_output("#{bin}/stacked-prs --help 2>&1")
  end
end
