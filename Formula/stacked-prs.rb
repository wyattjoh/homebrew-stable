class StackedPrs < Formula
  desc "Manage stacked branches and pull requests"
  homepage "https://github.com/wyattjoh/stacked-prs"
  version "1.10.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v1.10.1/stacked-prs-aarch64-apple-darwin.tar.gz"
      sha256 "9c3eea7765e20e2b1e11db83b6c6c98d32359e47812093c0d8e5db99c094d23b"

      def install
        bin.install "stacked-prs"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v1.10.1/stacked-prs-x86_64-apple-darwin.tar.gz"
      sha256 "9de6f416e1b80af5ab85eefa16565dea9e305a44fc4e57954cb6bf8436a19d13"

      def install
        bin.install "stacked-prs"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v1.10.1/stacked-prs-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "05ac55e8cf50bc918f5fcc3922bc2049955d7fcfed4d1a9f8f344ffb579387c6"

      def install
        bin.install "stacked-prs"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/wyattjoh/stacked-prs/releases/download/stacked-prs-v1.10.1/stacked-prs-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "fc4228cf3bb369643819daba504ebf9fe855ff09432dc0428d2422502c355706"

      def install
        bin.install "stacked-prs"
      end
    end
  end

  test do
    assert_match "stacked-prs", shell_output("#{bin}/stacked-prs --help 2>&1")
  end
end
