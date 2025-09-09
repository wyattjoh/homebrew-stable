class ClaudeCodeNotification < Formula
  desc "A notification hook for use with Claude Code"
  homepage "https://github.com/wyattjoh/claude-code-notification"
  url "https://github.com/wyattjoh/claude-code-notification.git",
      tag:      "v0.2.0",
      revision: "4fff21405ac8b4645c5a11f5ab756bf4e7b8d498"
  license "MIT"
  head "https://github.com/wyattjoh/claude-code-notification.git", branch: "main"

  depends_on "rust" => :build

  def install
    # Compile the Rust application to a standalone binary
    system "cargo", "install", *std_cargo_args
  end

  test do
    # Test that the binary runs and shows help
    assert_match "claude-code-notification", shell_output("#{bin}/claude-code-notification --help 2>&1")
  end
end