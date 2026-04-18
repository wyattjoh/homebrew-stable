class StackedPrs < Formula
  desc "Manage stacked branches and pull requests"
  homepage "https://github.com/wyattjoh/stacked-prs"
  version "2.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v2.2.0/stacked-prs-aarch64-apple-darwin.tar.gz"
      sha256 "6e2ed496af90f6919b1fb147ce0227a019440beb9a4148bfe2cb7bc008941d1d"

      def install
        bin.install "stacked-prs"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v2.2.0/stacked-prs-x86_64-apple-darwin.tar.gz"
      sha256 "9f6a20607ad7beb7b76b785c18d4d8cfc1012bdba59f7830519f823ce91870c6"

      def install
        bin.install "stacked-prs"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v2.2.0/stacked-prs-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "aac4ea8c3be97edf6c016b0b817a2b3a7415a7c3efa5f1d31bfb19633f3ba08f"

      def install
        bin.install "stacked-prs"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v2.2.0/stacked-prs-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "50e1d6a9b385c1dde7bf09fa3c4dce6d19ffd069dd7e19e117b211b22de5a126"

      def install
        bin.install "stacked-prs"
      end
    end
  end

  test do
    assert_match "stacked-prs", shell_output("#{bin}/stacked-prs --help 2>&1")
  end
end
